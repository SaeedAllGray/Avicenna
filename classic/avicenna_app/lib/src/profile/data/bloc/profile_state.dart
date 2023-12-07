part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileInProgress extends ProfileState {}

class ProfileFetched extends ProfileState {
  final User user;

  ProfileFetched({required this.user});
}

class ProfileFailed extends ProfileState {}

class DeletionOrLogoutSucceed extends ProfileState {}
