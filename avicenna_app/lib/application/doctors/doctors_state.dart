part of 'doctors_bloc.dart';

sealed class DoctorsState extends Equatable {
  const DoctorsState();

  @override
  List<Object> get props => [];
}

final class DoctorsInitial extends DoctorsState {}

class SearchInProgress extends DoctorsState {}

class SearchSucceed extends DoctorsState {
  final List<Doctor> doctors;

  const SearchSucceed(this.doctors);
}
