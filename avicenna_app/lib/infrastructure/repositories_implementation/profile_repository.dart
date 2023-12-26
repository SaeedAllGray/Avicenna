import 'dart:convert';

import 'package:avicenna_app/domain/entries/doctor/doctor.dart';
import 'package:avicenna_app/domain/entries/patient/patient.dart';
import 'package:avicenna_app/domain/entries/user.dart';
import 'package:avicenna_app/infrastructure/data_sources/local/local_source.dart';
import 'package:avicenna_app/infrastructure/data_sources/remote/auth_data_source.dart';
import 'package:avicenna_app/presentation/constants/api_constant.dart';
import 'package:dio/dio.dart';

class UserRepository {
  final LocalSource _localSource = LocalSource.getInstance();
  final AuthDataSource _authDataSource = AuthDataSource();
  Future<User?> fetchUser() async {
    String type = await _localSource.getType() ?? '';
    String user = await _localSource.getUser() ?? '';

    Map<String, dynamic> userMap = jsonDecode(user);
    if (type == ApiConstants.DOCTOR) {
      return Doctor.fromJson(userMap);
    } else if (type == ApiConstants.PATIENT) {
      return Patient.fromJson(userMap);
    }
    return null;
  }

  void logout() {
    _localSource.clearStorage();
  }

  Future<bool> login(String username, String password) async {
    final Response response = await _authDataSource.login(username, password);
    if (response.statusCode == 200) {
      _localSource.saveUser(response.data[ApiConstants.USER]);
      _localSource.setToken(response.data[ApiConstants.TOKEN]);
      _localSource.setType(response.data[ApiConstants.TYPE]);
      return true;
    }
    return false;
  }

  Future<bool> signup(User user) async {
    Response response = await _authDataSource.signup(user);
    if (response.statusCode == 200) {
      _localSource.saveUser(response.data[ApiConstants.USER]);
      _localSource.setToken(response.data[ApiConstants.TOKEN]);
      _localSource.setType(response.data[ApiConstants.TYPE]);

      return true;
    }
    return false;
  }
}
