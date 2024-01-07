part of 'patients_bloc.dart';

sealed class PatientsEvent extends Equatable {
  const PatientsEvent();

  @override
  List<Object> get props => [];
}

class GetPatientDetails extends PatientsEvent {
  final int patientId;

  const GetPatientDetails(this.patientId);
}
