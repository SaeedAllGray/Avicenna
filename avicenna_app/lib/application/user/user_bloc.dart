import 'dart:async';

import 'package:avicenna_app/domain/entries/patient/patient.dart';
import 'package:avicenna_app/domain/entries/user.dart';
import 'package:avicenna_app/domain/entries/user/user.dart';
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
    AbstractUser? user; //= await userRepository.fetchUser();
    // user = Doctor(
    //   phoneNumber: "+49 155 10517528",
    //   address: "Kampstrasse, 44135, Dortmund",
    //   id: 7216660,
    //   firstName: "Dr Andy",
    //   lastName: "Azmoodeh",
    //   username: "Picaroon",
    //   email: "Andy.Azmoodehe@icloud.com",
    //   specialization: "German Traditions",
    // );
    user = Patient(
        ssn: '32233232',
        birthDate: DateTime.now(),
        user: User(
            id: 1,
            firstName: 'firstName',
            lastName: 'lastName',
            username: 'username',
            email: 'email'));
    // if (user != null) {
    emit(UserFetchedState(user: user));
    // }
  }
}
