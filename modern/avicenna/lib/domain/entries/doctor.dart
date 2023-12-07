import 'package:avicenna/domain/value_objects/user_info.dart';

class Doctor {
  final UserInfo userInfo;
  final String specialization;

  Doctor({required this.userInfo, required this.specialization});
}
