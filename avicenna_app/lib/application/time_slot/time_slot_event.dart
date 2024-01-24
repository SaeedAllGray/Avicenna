part of 'time_slot_bloc.dart';

sealed class TimeSlotEvent extends Equatable {
  const TimeSlotEvent();

  @override
  List<Object> get props => [];
}

class GetDoctorAvailableTimeSlots extends TimeSlotEvent {
  final int doctorId;

  const GetDoctorAvailableTimeSlots({required this.doctorId});
}

class GetUserTimeSlots extends TimeSlotEvent {}

class CreateTimeSlot extends TimeSlotEvent {
  final TimeSlot timeSlot;

  const CreateTimeSlot({required this.timeSlot});
}

class GetPendingTimeSlots extends TimeSlotEvent {
  const GetPendingTimeSlots();
}

class UpdateTimeSlot extends TimeSlotEvent {
  final TimeSlot timeSlot;

  const UpdateTimeSlot({required this.timeSlot});
}

class ReserveTimeSlot extends TimeSlotEvent {
  final TimeSlot timeSlot;

  const ReserveTimeSlot({required this.timeSlot});
}
