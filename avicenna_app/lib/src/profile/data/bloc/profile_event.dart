part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUserInfoEvent extends ProfileEvent {}

class DeleteGetUser extends ProfileEvent {}
