import 'dart:async';

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
  }

  FutureOr<void> _onLogoutEvent(
      LogoutEvent event, Emitter<UserState> emit) async {
    userRepository.logout();
    emit(UserLoggedOutState());
  }

  FutureOr<void> _onGetUserEvent(
      GetUserEvent event, Emitter<UserState> emit) async {
    User? user; //= await userRepository.fetchUser();
    // user = Doctor(
    //   phoneNumber: "+49 155 10517528",
    //   address: "Kampstrasse, 44135, Dortmund",
    //   id: 7216660,
    //   firstName: "Dr Arthur",
    //   lastName: "Zevalov",
    //   username: "Picaroon",
    //   email: "arthur.zevalove@icloud.com",
    //   specialization: "German Traditions",
    // );
    user = Patient(
        birthDate: DateTime(2001, 3, 9),
        id: 7216660,
        firstName: "Dr Arthur",
        lastName: "Zevalov",
        username: "Picaroon",
        ssn: '7216660',
        email: "arthur.zevalove@icloud.com");
    // if (user != null) {
    emit(UserFetchedState(user: user));
    // }
  }
}
