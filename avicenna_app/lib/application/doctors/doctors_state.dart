part of 'doctors_bloc.dart';

sealed class DoctorsState extends Equatable {
  const DoctorsState();

  @override
  List<Object> get props => [];
}

final class DoctorsInitial extends DoctorsState {}

class DoctorsInProgress extends DoctorsState {}

class DoctorsSucceed extends DoctorsState {
  final List<Doctor> doctors;

  const DoctorsSucceed(this.doctors);
  @override
  List<Object> get props => [doctors];
}
