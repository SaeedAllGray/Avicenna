import 'dart:convert';

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

    if (user.isNotEmpty) {
      Map<String, dynamic> userMap = json.decode(user);

      if (userMap[ApiConstants.USER][ApiConstants.DOCTOR_ID] != null) {
        return Doctor.fromJson(userMap);
      } else if (userMap[ApiConstants.USER][ApiConstants.PATIENT_ID] != null) {
        return Patient.fromJson(userMap);
      }
    }

    return null;
  }

  Future<bool> deleteUser(User user) async {
    final String token = await _localSource.getToken() ?? '';
    Response response = await _authDataSource.deleteUser(user.id!, token);
    await _localSource.clearStorage();
    return response.statusCode == 204;
  }

  Future<int?> fetchUserId() async {
    String user = await _localSource.getUser() ?? '';

    Map<String, dynamic> userMap = jsonDecode(user);

    if (userMap[ApiConstants.USER][ApiConstants.DOCTOR_ID] != null) {
      return Doctor.fromJson(userMap).user.id;
    } else if (userMap[ApiConstants.USER][ApiConstants.PATIENT_ID] != null) {
      return Patient.fromJson(userMap).user.id;
    }

    return null;
  }

  void logout() async {
    await _localSource.clearStorage();
    ApiConstants.setIsTheFirstTimeAppLaunch();
  }

  Future<AbstractUser?> login(String username, String password) async {
    try {
      final Response response = await _authDataSource.login(username, password);
      await _localSource.saveUser(jsonEncode(response.data));
      await _localSource.setToken(response.data[ApiConstants.TOKEN].toString());
      await ApiConstants.setToken();
      if (response.data["user"]["doctor_id"] != null) {
        return Doctor.fromJson(response.data);
      } else {
        return Patient.fromJson(response.data);
      }
      // ignore: empty_catches
    } catch (e) {}
    return null;
  }

  Future<User?> createUser(User user, String password) async {
    try {
      Response response = await _authDataSource.createUser(user, password);
      if (response.statusCode! < 400) {
        return User.fromJson(response.data);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<Patient?> signupPatient(Patient patient) async {
    try {
      Response response = await _authDataSource.signupPatient(patient);
      if (response.statusCode == 201) {
        return patient;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<Doctor?> signupDoctor(Doctor doctor) async {
    try {
      Response response = await _authDataSource.signupDoctor(doctor);
      if (response.statusCode == 201) {
        return doctor;
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
