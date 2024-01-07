part of 'patients_bloc.dart';

sealed class PatientsState extends Equatable {
  const PatientsState();

  @override
  List<Object> get props => [];
}

final class PatientsInitial extends PatientsState {}

class PatientDetailsFetched extends PatientsState {
  final Patient patient;

  const PatientDetailsFetched(this.patient);
}

class PatientsInProgress extends PatientsState {}
