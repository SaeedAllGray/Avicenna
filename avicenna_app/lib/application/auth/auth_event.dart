part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CheckUserEvent extends AuthEvent {}

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

class CreateUserEvent extends AuthEvent {
  final User user;
  final String password;

  const CreateUserEvent({
    required this.user,
    required this.password,
  });
}

class SignUpPatientEvent extends AuthEvent {
  final Patient patient;

  const SignUpPatientEvent({required this.patient});
}

class SignUpDoctorEvent extends AuthEvent {
  final Doctor doctor;

  const SignUpDoctorEvent({required this.doctor});
}

class ToggleAuthEvent extends AuthEvent {
  final String uuid = const Uuid().v4();

  @override
  List<Object> get props => [uuid];
}
