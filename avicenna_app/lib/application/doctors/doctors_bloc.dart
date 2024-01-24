import 'dart:async';

import 'package:avicenna_app/domain/entries/doctor/doctor.dart';
import 'package:avicenna_app/infrastructure/repositories_implementation/doctor_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'doctors_event.dart';
part 'doctors_state.dart';

class DoctorsBloc extends Bloc<DoctorsEvent, DoctorsState> {
  List<Doctor> doctors = [];
  DoctorsBloc() : super(DoctorsInitial()) {
    on<GetDoctors>(_onGetDoctorsEvent);
    on<SearchDoctors>(_onSearchDoctorsEvent);
    on<GetDoctorDetails>(_onGetDoctorDetailsEvent);
  }

  FutureOr<void> _onGetDoctorDetailsEvent(
      GetDoctorDetails event, Emitter<DoctorsState> emit) async {
    emit(DoctorsInProgress());
    DoctorRepository repository = DoctorRepository();
    Doctor doctor = await repository.fetchEntity(event.doctorId);
    emit(DoctorDetailsFetched(doctor));
  }

  FutureOr<void> _onGetDoctorsEvent(
      GetDoctors event, Emitter<DoctorsState> emit) async {
    emit(DoctorsInProgress());
    DoctorRepository repository = DoctorRepository();
    doctors = await repository.fetchEntities();
    emit(DoctorsSucceed(doctors));
  }

  FutureOr<void> _onSearchDoctorsEvent(
      SearchDoctors event, Emitter<DoctorsState> emit) async {
    emit(DoctorsSucceed(doctors
        .where((doc) =>
            doc.specialization
                .toLowerCase()
                .startsWith(event.searchTerm.toLowerCase()) ||
            doc.user.firstName
                .toLowerCase()
                .startsWith(event.searchTerm.toLowerCase()) ||
            doc.user.lastName
                .toLowerCase()
                .startsWith(event.searchTerm.toLowerCase()))
        .toList()));
  }
}
