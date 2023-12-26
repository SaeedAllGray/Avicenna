import 'dart:developer';

import 'package:avicenna_app/domain/entries/doctor/doctor.dart';
import 'package:avicenna_app/infrastructure/data_sources/remote/doctor_remote_data_source.dart';
import 'package:avicenna_app/infrastructure/data_sources/remote/remote_data_source.dart';
import 'package:avicenna_app/domain/repositories/entity_repository.dart';

class DoctorRepository implements EntityRepository {
  @override
  RemoteDataSource api = DoctorRemoteDataSource();

  @override
  Future<List<Doctor>> fetchEntities() async {
    List<dynamic> response = await api.fetchEntities();
    log(response.toString());
    return response.map((data) => Doctor.fromJson(data)).toList();
  }

  @override
  Future fetchEntity() {
    // TODO: implement fetchEntity
    throw UnimplementedError();
  }
}
