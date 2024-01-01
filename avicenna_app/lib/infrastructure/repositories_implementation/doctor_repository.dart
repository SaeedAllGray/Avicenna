import 'dart:developer';

import 'package:avicenna_app/domain/entries/doctor/doctor.dart';
import 'package:avicenna_app/infrastructure/data_sources/remote/doctor_remote_data_source.dart';
import 'package:avicenna_app/domain/repositories/entity_repository.dart';

class DoctorRepository
    implements EntityRepository<Doctor, DoctorRemoteDataSource> {
  @override
  DoctorRemoteDataSource api = DoctorRemoteDataSource();

  @override
  Future<List<Doctor>> fetchEntities() async {
    List<dynamic> response = await api.fetchEntities();
    log(response.toString());
    return response.map((data) => Doctor.fromJson(data)).toList();
  }

  @override
  Future<Doctor> fetchEntity(int id) async {
    dynamic response = await api.fetchAnEntity(id);
    return Doctor.fromJson(response);
  }
}
