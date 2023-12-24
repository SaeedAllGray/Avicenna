part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class InputEvent extends AuthEvent {
  final String uuid = const Uuid().v4();

  @override
  List<Object> get props => [uuid];
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  const LoginEvent(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}

class SignUpDoctorEvent extends AuthEvent {
  final Doctor doctor;
  final String password;
  const SignUpDoctorEvent(this.doctor, this.password);
}

class SignUpPatientEvent extends AuthEvent {
  final Patient patient;
  final String password;

  const SignUpPatientEvent(this.patient, this.password);
}

class ToggleAuthEvent extends AuthEvent {
  final String uuid = const Uuid().v4();

  @override
  List<Object> get props => [uuid];
}
