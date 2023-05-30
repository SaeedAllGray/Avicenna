part of 'search_bloc.dart';

@immutable
abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchInProgress extends SearchState {}

class SearchSucceed extends SearchState {
  final List<Doctor> doctors;

  const SearchSucceed(this.doctors);
}
