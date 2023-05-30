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
  SearchBloc() : super(SearchInitial()) {
    on<SearchRequestedEvent>(_onSearchRequestedEvent);
  }
  FutureOr<void> _onSearchRequestedEvent(
    SearchRequestedEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchInProgress());
    List<Doctor> doctors =
        await SearchApi().fetchSearchResult(event.searchTerm);
    emit(SearchSucceed(doctors));
  }
}
