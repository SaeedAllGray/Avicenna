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
  final bool isDoctor;

  const AuthSucceedState({required this.isDoctor});
}

class AuthFailedState extends AuthState {}
