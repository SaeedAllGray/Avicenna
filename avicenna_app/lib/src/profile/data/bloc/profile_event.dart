part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUserInfoEvent extends ProfileEvent {}

class DeleteUser extends ProfileEvent {}
