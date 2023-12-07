part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class InitialState extends SplashState {}

class UserExistsState extends SplashState {}

class UserDoesNotExistState extends SplashState {}
