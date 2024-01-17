import 'dart:convert';
import 'dart:developer';

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
  Future<AbstractUser?> fetchUser() async {
    String user = await _localSource.getUser() ?? '';
    print(user);
    Map<String, dynamic> userMap = jsonDecode(user);

    if (userMap[ApiConstants.USER][ApiConstants.DOCTOR_ID] != null) {
      return Doctor.fromJson(userMap);
    } else if (userMap[ApiConstants.USER][ApiConstants.PATIENT_ID] != null) {
      return Patient.fromJson(userMap);
    }

    return null;
  }

  Future<int?> fetchUserId() async {
    String user = await _localSource.getUser() ?? '';
    print(user);
    Map<String, dynamic> userMap = jsonDecode(user);

    if (userMap[ApiConstants.USER][ApiConstants.DOCTOR_ID] != null) {
      return Doctor.fromJson(userMap).user.id;
    } else if (userMap[ApiConstants.USER][ApiConstants.PATIENT_ID] != null) {
      return Patient.fromJson(userMap).user.id;
    }

    return null;
  }

  void logout() {
    _localSource.clearStorage();
  }

  Future<bool> login(String username, String password) async {
    final Response response = await _authDataSource.login(username, password);
    if (response.statusCode == 200) {
      _localSource.saveUser(jsonEncode(response.data));
      _localSource.setToken(response.data[ApiConstants.TOKEN].toString());

      return true;
    }
    return false;
  }

  Future<bool> signup(AbstractUser user) async {
    Response response = await _authDataSource.signup(user);
    if (response.statusCode == 200) {
      _localSource.saveUser(response.data[ApiConstants.USER]);
      _localSource.setToken(response.data[ApiConstants.TOKEN]);

      return true;
    }
    return false;
  }
}
