import 'dart:async';

import 'package:avicenna_app/src/auth/data/providers/auth_api.dart';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final AuthApi _authApi = AuthApi();
  Future<bool> login(String username, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      Response<dynamic> response = await _authApi.login(username, password);
      await sharedPreferences.setString("userinfo", response.data);
      print(sharedPreferences.getString("userinfo"));
    } catch (e) {
      return false;
    }
    sharedPreferences.setBool('is_signed_in', true);
    return true;
  }
}
