part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {
  final String uuid = const Uuid().v4();

  @override
  List<Object> get props => [uuid];
}

class AuthInProgress extends AuthState {}

class AuthSucceedState extends AuthState {
  final AbstractUser user;

  const AuthSucceedState({required this.user});
}

class UserCreatedState extends AuthState {
  final String uuid = const Uuid().v4();
  final User user;

  UserCreatedState({required this.user});

  @override
  List<Object> get props => [uuid];
}

class AuthFailedState extends AuthState {}
