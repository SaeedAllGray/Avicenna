import 'dart:async';

import 'package:avicenna_app/domain/entries/time_slot/time_slot.dart';
import 'package:avicenna_app/infrastructure/repositories_implementation/time_slot_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'time_slot_event.dart';
part 'time_slot_state.dart';

class TimeSlotBloc extends Bloc<TimeSlotEvent, TimeSlotState> {
  TimeSlotBloc() : super(TimeSlotsInitial()) {
    on<GetTimeSlots>(_onGetDoctorsEvent);
  }
  FutureOr<void> _onGetDoctorsEvent(
      GetTimeSlots event, Emitter<TimeSlotState> emit) async {
    emit(TimeSlotsInProgress());
    TimeSlotRepository repository = TimeSlotRepository();
    List<TimeSlot> timeSlots = await repository.fetchEntities();
    emit(TimeSlotsFetched(timeSlots: timeSlots));
  }
}
