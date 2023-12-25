import 'dart:async';

import 'package:avicenna_app/domain/entries/doctor/doctor.dart';
import 'package:avicenna_app/domain/entries/patient/patient.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  bool signupActive = false;
  AuthBloc() : super(AuthInitialState()) {
    on<LoginEvent>(_onLoginEvent);
    on<InputEvent>(_onInputEvent);
    on<SignUpDoctorEvent>(_onSignUpDoctorEvent);
    on<SignUpPatientEvent>(_onSignUpPatientEvent);
    on<ToggleAuthEvent>(_onToggleEvent);
  }

  FutureOr<void> _onLoginEvent(
      LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthInProgress());
    // bool loginSucceed =
    // await AuthRepository().login(event.username, event.password);
    // if (loginSucceed) {
    //   emit(AuthSucceedState());
    // } else {
    //   emit(AuthFailedState());
    // }
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
}
