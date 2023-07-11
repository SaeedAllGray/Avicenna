import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<GetUserInfoEvent>(_onGetUserInfoEvent);
  }

  FutureOr<void> _onGetUserInfoEvent(
      GetUserInfoEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileInProgress());
    // bool loginSucceed =
    //     await AuthRepository().login(event.username, event.password);
    // if (loginSucceed) {
    //   emit(AuthSucceedState());
    // } else {
    //   emit(AuthFailedState());
    // }
  }
}
