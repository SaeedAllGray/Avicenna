part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserEvent extends UserEvent {}

class LogoutEvent extends UserEvent {}

class DeleteUserEvent extends UserEvent {}
