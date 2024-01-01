import 'dart:async';

import 'package:avicenna_app/domain/entries/patient/patient.dart';
import 'package:avicenna_app/infrastructure/repositories_implementation/patient_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'patients_event.dart';
part 'patients_state.dart';

class PatientsBloc extends Bloc<PatientsEvent, PatientsState> {
  PatientsBloc() : super(PatientsInitial()) {
    on<GetPatientDetails>(_onGetPatientDetailsEvent);
  }
  FutureOr<void> _onGetPatientDetailsEvent(
      GetPatientDetails event, Emitter<PatientsState> emit) async {
    emit(PatientsInProgress());
    PatientRepository repository = PatientRepository();
    Patient patient = await repository.fetchEntity(event.patientId);
    emit(PatientDetailsFetched(patient));
  }
}
