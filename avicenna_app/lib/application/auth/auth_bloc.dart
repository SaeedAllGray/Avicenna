import 'dart:async';

import 'package:avicenna_app/domain/entries/doctor/doctor.dart';
import 'package:avicenna_app/domain/entries/patient/patient.dart';
import 'package:avicenna_app/domain/entries/user.dart';
import 'package:avicenna_app/domain/entries/user/user.dart';

import 'package:avicenna_app/infrastructure/repositories_implementation/profile_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository repository = UserRepository();
  bool signupActive = false;
  AuthBloc() : super(AuthInitialState()) {
    on<CheckUserEvent>(_onCheckUserEvent);
    on<LoginEvent>(_onLoginEvent);
    on<InputEvent>(_onInputEvent);
    on<SignUpDoctorEvent>(_onSignUpDoctorEvent);
    on<SignUpPatientEvent>(_onSignUpPatientEvent);
    on<ToggleAuthEvent>(_onToggleEvent);
  }

  FutureOr<void> _onLoginEvent(
      LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthInProgress());
    final bool loginSucceed = true;
    // await repository.login(event.username, event.password);
    if (loginSucceed) {
      // final User? user = await repository.fetchUser();
      final AbstractUser user = Doctor(
          specialization: 'specialization',
          phoneNumber: 'phoneNumber',
          address: 'address',
          user: User(
              email: ' ', firstName: ' ', id: 1, lastName: ' ', username: ' '));
      emit(AuthSucceedState(user: user));
    } else {
      emit(AuthFailedState());
    }
  }

  FutureOr<void> _onSignUpDoctorEvent(
      SignUpDoctorEvent event, Emitter<AuthState> emit) async {}

  FutureOr<void> _onSignUpPatientEvent(
      SignUpPatientEvent event, Emitter<AuthState> emit) async {}

  FutureOr<void> _onInputEvent(InputEvent event, Emitter<AuthState> emit) {
    emit(AuthInitialState());
  }

  FutureOr<void> _onToggleEvent(
      ToggleAuthEvent event, Emitter<AuthState> emit) {
    signupActive = !signupActive;
    emit(AuthInitialState());
  }

  FutureOr<void> _onCheckUserEvent(
      CheckUserEvent event, Emitter<AuthState> emit) async {
    AbstractUser? user = //await repository.fetchUser();
        Doctor(
            phoneNumber: "+49 155 10517528",
            address: "Kampstrasse, 44135, Dortmund",
            specialization: ' ',
            user: User(
                id: 2,
                firstName: 'firstName',
                lastName: 'lastName',
                username: 'username',
                email: 'email@deu.com'));
    // if (user != null) {
    emit(AuthSucceedState(user: user));
    // }
  }
}
