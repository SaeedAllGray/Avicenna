part of 'time_slot_bloc.dart';

sealed class TimeSlotEvent extends Equatable {
  const TimeSlotEvent();

  @override
  List<Object> get props => [];
}

class GetUserTimeSlots extends TimeSlotEvent {
  final int userID;

  const GetUserTimeSlots({required this.userID});
}

class CreateTimeSlot extends TimeSlotEvent {
  final TimeSlot timeSlot;

  const CreateTimeSlot({required this.timeSlot});
}

class GetBookedTimeSlots extends TimeSlotEvent {
  final int doctorId;

  const GetBookedTimeSlots({required this.doctorId});
}
