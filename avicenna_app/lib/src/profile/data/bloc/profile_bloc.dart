import 'dart:async';
import 'dart:convert';

import 'package:avicenna_app/src/constants/api_constant.dart';
import 'package:avicenna_app/src/models/doctor.dart';
import 'package:avicenna_app/src/models/patient.dart';
import 'package:avicenna_app/src/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<GetUserInfoEvent>(_onGetUserInfoEvent);
    on<DeleteUser>(_onDeleteUser);
    on<Logout>(_onLogout);
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

  FutureOr<void> _onLogout(Logout event, Emitter<ProfileState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    emit(DeletionOrLogoutSucceed());
  }

  FutureOr<void> _onDeleteUser(
      DeleteUser event, Emitter<ProfileState> emit) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? jsonstr = prefs.getString("userinfo");
      if (jsonstr != null) {
        List<dynamic> json = jsonDecode(jsonstr);
        http.Response response = await http.delete(
          Uri.parse(
            '${ApiConstants.baseUrl}delete-user/${json[0]["pk"]}/',
          ),
        );
        print(response.statusCode);
        await prefs.clear();
      }
    } catch (e) {
      print(e);
    }
    emit(DeletionOrLogoutSucceed());
  }
}
