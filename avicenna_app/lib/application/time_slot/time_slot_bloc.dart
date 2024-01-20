import 'dart:async';
import 'dart:developer';

import 'package:avicenna_app/domain/entries/doctor/doctor.dart';
import 'package:avicenna_app/domain/entries/patient/patient.dart';
import 'package:avicenna_app/domain/entries/time_slot/time_slot.dart';
import 'package:avicenna_app/domain/entries/user.dart';
import 'package:avicenna_app/infrastructure/repositories_implementation/profile_repository.dart';
import 'package:avicenna_app/infrastructure/repositories_implementation/time_slot_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'time_slot_event.dart';
part 'time_slot_state.dart';

class TimeSlotBloc extends Bloc<TimeSlotEvent, TimeSlotState> {
  final TimeSlotRepository repository = TimeSlotRepository();
  TimeSlotBloc() : super(TimeSlotsInitial()) {
    on<GetUserTimeSlots>(_onGetUserTimeSlotsEvent);
    on<CreateTimeSlot>(_onCreateTimeSlotEvent);
    on<GetPendingTimeSlots>(_onGetPendingTimeSlots);
    on<UpdateTimeSlot>(_onCancelTimeSlotEvent);
    on<GetDoctorAvailableTimeSlots>(_onGetDoctorAvailableTimeSlotsEvent);
  }
  FutureOr<void> _onCancelTimeSlotEvent(
      UpdateTimeSlot event, Emitter<TimeSlotState> emit) async {
    await repository.cancelTimeSlot(event.timeSlot);
  }

  FutureOr<void> _onGetDoctorAvailableTimeSlotsEvent(
      GetDoctorAvailableTimeSlots event, Emitter<TimeSlotState> emit) async {
    emit(TimeSlotsInProgress());

    final List<TimeSlot> timeSlots =
        await repository.fetchUserTimeSlots(event.doctorId);
    emit(TimeSlotsFetched(timeSlots: timeSlots));
  }

  FutureOr<void> _onGetUserTimeSlotsEvent(
      GetUserTimeSlots event, Emitter<TimeSlotState> emit) async {
    emit(TimeSlotsInProgress());
    int? userId = await UserRepository().fetchUserId();

    if (userId != null) {
      final List<TimeSlot> timeSlots =
          await repository.fetchUserTimeSlots(userId);
      emit(TimeSlotsFetched(timeSlots: timeSlots));
    }
  }

  FutureOr<void> _onCreateTimeSlotEvent(
      CreateTimeSlot event, Emitter<TimeSlotState> emit) async {
    emit(TimeSlotsInProgress());
    int? doctorId = await UserRepository().fetchUserId();
    if (doctorId != null) {
      event.timeSlot.doctorId = doctorId;
      await repository.createTimeSlot(event.timeSlot);
      log("_onCreateTimeSlotEvent");
      List<TimeSlot> timeSlots = await repository.fetchUserTimeSlots(doctorId);
      emit(TimeSlotsFetched(timeSlots: timeSlots));
    }
  }

  FutureOr<void> _onGetPendingTimeSlots(
      GetPendingTimeSlots event, Emitter<TimeSlotState> emit) async {
    emit(TimeSlotsInProgress());
    int? doctorId = await UserRepository().fetchUserId();
    if (doctorId != null) {
      final List<TimeSlot> timeSlots =
          await repository.fetchUserTimeSlots(doctorId);
      emit(
        TimeSlotsFetched(
          timeSlots: timeSlots
              .where((element) =>
                  element.isBooked! &&
                  !element.isConfirmed! &&
                  !element.isCancelled!)
              .toList(),
        ),
      );
    }
  }
}
