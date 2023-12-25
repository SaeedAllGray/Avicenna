import 'dart:async';

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
  }

  FutureOr<void> _onLogoutEvent(
      LogoutEvent event, Emitter<UserState> emit) async {
    userRepository.logout();
    emit(UserLoggedOutState());
  }

  FutureOr<void> _onGetUserEvent(
      GetUserEvent event, Emitter<UserState> emit) async {
    final User user = await userRepository.fetchUser();
    emit(UserFetchedState(user: user));
  }
}
