part of 'splash_bloc.dart';

@immutable
abstract class SplashEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckUserEvent extends SplashEvent {}
