import 'dart:developer';

import 'package:avicenna_app/domain/entries/doctor/doctor.dart';
import 'package:avicenna_app/infrastructure/data_sources/remote/doctor_remote_data_source.dart';

class DoctorRepository {
  DoctorRemoteDataSource api = DoctorRemoteDataSource();
  Future<List<Doctor>> fetchDoctors() async {
    List<dynamic> response = await api.fetchEntities();
    log(response.toString());
    return response.map((data) => Doctor.fromJson(data)).toList();
  }
}
