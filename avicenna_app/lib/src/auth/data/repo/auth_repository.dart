import 'dart:async';

import 'package:avicenna_app/src/auth/data/providers/auth_api.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final AuthApi _authApi = AuthApi();
  Future<bool> login(String username, String password) async {
    try {
      await _authApi.login(username, password);
    } catch (e) {
      return false;
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('is_signed_in', true);
    return true;
  }
}
