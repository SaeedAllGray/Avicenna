import 'dart:async';
import 'dart:developer';

import 'package:avicenna_app/domain/entries/time_slot/time_slot.dart';
import 'package:avicenna_app/infrastructure/repositories_implementation/time_slot_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'time_slot_event.dart';
part 'time_slot_state.dart';

class TimeSlotBloc extends Bloc<TimeSlotEvent, TimeSlotState> {
  TimeSlotBloc() : super(TimeSlotsInitial()) {
    on<GetDoctorTimeSlots>(_onGetDoctorTimeSlotsEvent);
    on<GetPatientTimeSlots>(_onGetPatientTimeSlotsEvent);
    on<CreateTimeSlot>(_onCreateTimeSlotEvent);
  }
  FutureOr<void> _onGetDoctorTimeSlotsEvent(
      GetDoctorTimeSlots event, Emitter<TimeSlotState> emit) async {
    emit(TimeSlotsInProgress());
    TimeSlotRepository repository = TimeSlotRepository();
    List<TimeSlot> timeSlots =
        await repository.fetchDoctorTimeSlots(event.doctorId);
    emit(TimeSlotsFetched(timeSlots: timeSlots));
  }

  FutureOr<void> _onGetPatientTimeSlotsEvent(
      GetPatientTimeSlots event, Emitter<TimeSlotState> emit) async {
    emit(TimeSlotsInProgress());
    TimeSlotRepository repository = TimeSlotRepository();
    List<TimeSlot> timeSlots =
        await repository.fetchPatientTimeSlots(event.patientId);
    emit(TimeSlotsFetched(timeSlots: timeSlots));
  }

  FutureOr<void> _onCreateTimeSlotEvent(
      CreateTimeSlot event, Emitter<TimeSlotState> emit) async {
    emit(TimeSlotsInProgress());
    TimeSlotRepository repository = TimeSlotRepository();
    // TODO: call post function to create a time stamp
    log("_onCreateTimeSlotEvent");
    List<TimeSlot> timeSlots =
        await repository.fetchDoctorTimeSlots(event.timeSlot.doctorId);
    emit(TimeSlotsFetched(timeSlots: timeSlots));
  }
}
