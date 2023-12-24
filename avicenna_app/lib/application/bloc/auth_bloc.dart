import 'dart:async';

import 'package:avicenna_app/src/auth/data/repo/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<LoginEvent>(_onLoginEvent);
    on<InputEvent>(_onInputEvent);
  }

  FutureOr<void> _onLoginEvent(
      LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthInProgress());
    bool loginSucceed =
        await AuthRepository().login(event.username, event.password);
    if (loginSucceed) {
      emit(AuthSucceedState());
    } else {
      emit(AuthFailedState());
    }
  }

  FutureOr<void> _onInputEvent(InputEvent event, Emitter<AuthState> emit) {
    emit(AuthInitialState());
  }
}
