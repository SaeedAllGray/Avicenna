part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserEvent extends UserEvent {
  final User user;

  const GetUserEvent({required this.user});
}

class LogoutEvent extends UserEvent {}
