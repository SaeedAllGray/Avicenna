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
    on<SearchDoctors>(_onSearchDoctors);
  }

  FutureOr<void> _onGetDoctorsEvent(
      GetDoctors event, Emitter<DoctorsState> emit) async {
    emit(DoctorsInProgress());
    DoctorRepository repository = DoctorRepository();
    doctors = await repository.fetchDoctors();
    emit(DoctorsSucceed(doctors));
  }

  FutureOr<void> _onSearchDoctors(
      SearchDoctors event, Emitter<DoctorsState> emit) async {
    emit(DoctorsSucceed(doctors
        .where((doc) =>
            doc.specialization
                .toLowerCase()
                .startsWith(event.searchTerm.toLowerCase()) ||
            doc.firstName
                .toLowerCase()
                .startsWith(event.searchTerm.toLowerCase()) ||
            doc.lastName
                .toLowerCase()
                .startsWith(event.searchTerm.toLowerCase()))
        .toList()));
  }
}
