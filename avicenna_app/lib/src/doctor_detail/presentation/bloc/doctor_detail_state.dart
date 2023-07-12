part of 'doctor_detail_bloc.dart';

@immutable
abstract class DoctorDetailState {}

class DoctorDetailInitial extends DoctorDetailState {}

class DoctorDetailInProgress extends DoctorDetailState {}

class DoctorDetailInFetched extends DoctorDetailState {
  final List<Appointment> appointments;

  DoctorDetailInFetched(this.appointments);
}

class AppointmentCreated extends DoctorDetailState {}
