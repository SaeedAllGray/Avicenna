import 'dart:convert';

import 'package:avicenna_app/domain/entries/doctor/doctor.dart';
import 'package:avicenna_app/domain/entries/patient/patient.dart';
import 'package:avicenna_app/domain/entries/user.dart';
import 'package:avicenna_app/infrastructure/data_sources/local/local_source.dart';

class UserRepository {
  final LocalSource _localSource = LocalSource.getInstance();
  Future<User> fetchUser() async {
    String type = await _localSource.getType() ?? '';
    String user = await _localSource.getUser() ?? '';

    Map<String, dynamic> userMap = jsonDecode(user);
    if (type.contains('o')) {
      return Doctor.fromJson(userMap);
    } else {
      return Patient.fromJson(userMap);
    }
  }

  void logout() {
    _localSource.clearStorage();
  }
}
