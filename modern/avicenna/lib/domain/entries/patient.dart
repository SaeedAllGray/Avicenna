import 'package:avicenna/domain/value_objects/user_info.dart';

class Patient {
  final UserInfo userInfo;
  final DateTime birthDate;

  Patient({required this.userInfo, required this.birthDate});
}
