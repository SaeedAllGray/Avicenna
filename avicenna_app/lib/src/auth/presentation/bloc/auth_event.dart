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

class SignupEvent extends AuthEvent {}
