import 'dart:convert';
import 'dart:developer';

import 'package:avicenna_app/domain/entries/doctor/doctor.dart';
import 'package:avicenna_app/domain/entries/patient/patient.dart';
import 'package:avicenna_app/domain/entries/user.dart';
import 'package:avicenna_app/domain/entries/user/user.dart';

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
    if (user.isNotEmpty) {
      Map<String, dynamic> userMap = json.decode(user);
      print(userMap);
      if (userMap[ApiConstants.USER][ApiConstants.DOCTOR_ID] != null) {
        return Doctor.fromJson(userMap);
      } else if (userMap[ApiConstants.USER][ApiConstants.PATIENT_ID] != null) {
        return Patient.fromJson(userMap);
      }
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

  Future<AbstractUser?> login(String username, String password) async {
    final Response response = await _authDataSource.login(username, password);
    if (response.statusCode == 200) {
      _localSource.saveUser(jsonEncode(response.data));
      _localSource.setToken(response.data[ApiConstants.TOKEN].toString());
      if (response.data["user"]["doctor_id"] != null) {
        return Doctor.fromJson(response.data);
      } else {
        return Patient.fromJson(response.data);
      }
    }
  }

  Future<User?> createUser(User user, String password) async {
    Response response = await _authDataSource.createUser(user, password);

    if (response.statusCode! < 400) {
      return User.fromJson(response.data);
    }
    return null;
  }

  Future<Patient?> signupPatient(Patient patient) async {
    Response response = await _authDataSource.signupPatient(patient);
    if (response.statusCode == 200) {
      return Patient.fromJson(response.data);
    }
    return null;
  }

  Future<Doctor?> signupDoctor(Doctor doctor) async {
    Response response = await _authDataSource.signupDoctor(doctor);
    if (response.statusCode == 200) {
      return Doctor.fromJson(response.data);
    }
    return null;
  }
}
