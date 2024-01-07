part of 'time_slot_bloc.dart';

sealed class TimeSlotEvent extends Equatable {
  const TimeSlotEvent();

  @override
  List<Object> get props => [];
}

class GetDoctorTimeSlots extends TimeSlotEvent {
  final int doctorId;

  const GetDoctorTimeSlots({required this.doctorId});
}

class GetPatientTimeSlots extends TimeSlotEvent {
  final int patientId;

  const GetPatientTimeSlots({required this.patientId});
}

class CreateTimeSlot extends TimeSlotEvent {
  final TimeSlot timeSlot;

  const CreateTimeSlot({required this.timeSlot});
}

class GetBookedTimeSlots extends TimeSlotEvent {
  final int doctorId;

  const GetBookedTimeSlots({required this.doctorId});
}
