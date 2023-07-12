import 'dart:async';
import 'dart:convert';

import 'package:avicenna_app/src/constants/api_constant.dart';
import 'package:avicenna_app/src/models/doctor.dart';
import 'package:avicenna_app/src/models/patient.dart';
import 'package:avicenna_app/src/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<GetUserInfoEvent>(_onGetUserInfoEvent);
    on<DeleteUser>(_onDeleteUser);
  }

  FutureOr<void> _onGetUserInfoEvent(
      GetUserInfoEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileInProgress());

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? jsonstr = prefs.getString("userinfo");
    if (jsonstr != null) {
      List<dynamic> json = jsonDecode(jsonstr);
      if (json[0]["fields"]["is_doctor"]) {
        emit(ProfileFetched(user: Doctor.fromJson(json)));
      } else {
        print('doctor bye');
        emit(ProfileFetched(user: Patient.fromJson(json)));
      }
    } else {
      ProfileFailed();
    }
  }

  FutureOr<void> _onDeleteUser(
      DeleteUser event, Emitter<ProfileState> emit) async {
// http://10.211.1.76/api/delete-user/<int:user_id>/

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? jsonstr = prefs.getString("userinfo");
      if (jsonstr != null) {
        List<dynamic> json = jsonDecode(jsonstr);

        print(json[0]["pk"]);
        print('0000000000');
        await http.delete(
          Uri.parse(
            '${ApiConstants.baseUrl}delete-user/6',
          ),
        );
        await prefs.clear();
      }
    } catch (e) {
      print(e);
    }
    emit(DeletionSucceed());
  }
}
