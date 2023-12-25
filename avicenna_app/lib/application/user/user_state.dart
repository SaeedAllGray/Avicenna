part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitialState extends UserState {}

final class UserFetchedState extends UserState {
  final User user;

  const UserFetchedState({required this.user});
}

final class UserLoggedOutState extends UserState {}
