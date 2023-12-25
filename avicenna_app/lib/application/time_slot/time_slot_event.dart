part of 'time_slot_bloc.dart';

sealed class TimeSlotEvent extends Equatable {
  const TimeSlotEvent();

  @override
  List<Object> get props => [];
}

class GetTimeSlots extends TimeSlotEvent {
  // TODO: there should be a doctor's ID attribute here
}
