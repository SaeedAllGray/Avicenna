import 'dart:async';

import 'package:avicenna_app/src/models/doctor.dart';
import 'package:avicenna_app/src/search_tab/data/search_api.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  List<Doctor> doctors = [];
  SearchBloc() : super(SearchInitial()) {
    on<GetDoctors>(_onGettingDoctors);
  }
  FutureOr<void> _onGettingDoctors(
    GetDoctors event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchInProgress());
    if (doctors.isEmpty) {
      doctors = await SearchApi().getAllDoctors();
    }
    if (event.searchTerm.isEmpty) {
      emit(SearchSucceed(doctors));
    } else {
      emit(SearchSucceed(doctors
          .where((doc) =>
              doc.profession
                  .toLowerCase()
                  .startsWith(event.searchTerm.toLowerCase()) ||
              doc.firstname
                  .toLowerCase()
                  .startsWith(event.searchTerm.toLowerCase()) ||
              doc.lastname
                  .toLowerCase()
                  .startsWith(event.searchTerm.toLowerCase()))
          .toList()));
    }
    emit(SearchSucceed(doctors));
  }
}
