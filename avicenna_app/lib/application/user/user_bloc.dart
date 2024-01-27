import 'dart:async';

import 'package:avicenna_app/domain/entries/doctor/doctor.dart';
import 'package:avicenna_app/domain/entries/patient/patient.dart';
import 'package:avicenna_app/domain/entries/user.dart';
import 'package:avicenna_app/infrastructure/repositories_implementation/profile_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository = UserRepository();
  UserBloc() : super(UserInitialState()) {
    on<GetUserEvent>(_onGetUserEvent);
    on<LogoutEvent>(_onLogoutEvent);
    on<DeleteUserEvent>(_onDeleteUserEvent);
  }

  FutureOr<void> _onLogoutEvent(
      LogoutEvent event, Emitter<UserState> emit) async {
    userRepository.logout();
    emit(UserLoggedOutState());
  }

  FutureOr<void> _onGetUserEvent(
      GetUserEvent event, Emitter<UserState> emit) async {
    AbstractUser? user = await userRepository.fetchUser();

    if (user != null) {
      emit(UserFetchedState(user: user));
    }
  }

  FutureOr<void> _onDeleteUserEvent(
      DeleteUserEvent event, Emitter<UserState> emit) async {
    if (state is UserFetchedState) {
      final AbstractUser user = (state as UserFetchedState).user;
      bool succeed = false;
      if (user is Doctor) {
        succeed = await userRepository.deleteUser(user.user);
      } else if (user is Patient) {
        succeed = await userRepository.deleteUser(user.user);
      }
      if (succeed) {
        emit(UserLoggedOutState());
      }
    }
  }
}
