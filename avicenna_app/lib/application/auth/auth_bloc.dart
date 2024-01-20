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
    on<CreateUserEvent>(_onCreateUserEvent);
  }

  FutureOr<void> _onLoginEvent(
      LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthInProgress());
    final AbstractUser? user =
        await repository.login(event.username, event.password);

    if (user != null) {
      signupActive = false;
      emit(AuthSucceedState(user: user));
    } else {
      emit(AuthFailedState());
    }
  }

  FutureOr<void> _onSignUpDoctorEvent(
      SignUpDoctorEvent event, Emitter<AuthState> emit) async {
    if (state is UserCreatedState) {
      emit(AuthInProgress());
      Doctor? doctor = await repository.signupDoctor(event.doctor);
      if (doctor != null) {
        signupActive = false;
        emit(AuthInitialState());
      } else {
        emit(AuthFailedState());
      }
    }
  }

  FutureOr<void> _onSignUpPatientEvent(
      SignUpPatientEvent event, Emitter<AuthState> emit) async {
    if (state is UserCreatedState) {
      Patient? patient = await repository.signupPatient(event.patient);
      if (patient != null) {
        emit(AuthSucceedState(user: patient));
      } else {
        emit(AuthFailedState());
      }
    }
  }

  FutureOr<void> _onInputEvent(InputEvent event, Emitter<AuthState> emit) {
    if (state is AuthInitialState) {
      emit(AuthInitialState());
    } else if (state is UserCreatedState) {
      emit(UserCreatedState(user: (state as UserCreatedState).user));
    }
  }

  FutureOr<void> _onToggleEvent(
      ToggleAuthEvent event, Emitter<AuthState> emit) {
    signupActive = !signupActive;
    emit(AuthInitialState());
  }

  FutureOr<void> _onCheckUserEvent(
      CheckUserEvent event, Emitter<AuthState> emit) async {
    AbstractUser? user = await repository.fetchUser();

    if (user != null) {
      emit(AuthSucceedState(user: user));
    }
  }

  FutureOr<void> _onCreateUserEvent(
      CreateUserEvent event, Emitter<AuthState> emit) async {
    final User? user = await repository.createUser(event.user, event.password);
    if (user != null) {
      print(user);
      emit(UserCreatedState(user: user));
    }
  }
}
