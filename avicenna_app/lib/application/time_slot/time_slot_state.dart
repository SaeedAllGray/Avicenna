part of 'time_slot_bloc.dart';

sealed class TimeSlotState extends Equatable {
  const TimeSlotState();

  @override
  List<Object> get props => [];
}

final class TimeSlotsInitial extends TimeSlotState {}

class TimeSlotsInProgress extends TimeSlotState {}

class TimeSlotsFetched extends TimeSlotState {
  final List<TimeSlot> timeSlots;

  const TimeSlotsFetched({required this.timeSlots});
}
