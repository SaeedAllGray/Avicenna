part of 'doctor_detail_bloc.dart';

@immutable
abstract class DoctorDetailEvent {}

class GetAllAppointments extends DoctorDetailEvent {
  final int id;

  GetAllAppointments(this.id);
}

class MakeAppointment extends DoctorDetailEvent {
  final int doctorId;
  final DateTime dateTime;

  MakeAppointment(this.doctorId, this.dateTime);
}
