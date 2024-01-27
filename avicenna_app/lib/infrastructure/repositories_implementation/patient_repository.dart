import 'dart:developer';

import 'package:avicenna_app/domain/entries/patient/patient.dart';
import 'package:avicenna_app/domain/repositories/entity_repository.dart';
import 'package:avicenna_app/infrastructure/data_sources/remote/patient_remote_data_source.dart';

class PatientRepository
    implements EntityRepository<Patient, PatientRemoteDataSource> {
  @override
  PatientRemoteDataSource api = PatientRemoteDataSource();

  @override
  Future<List<Patient>> fetchEntities() async {
    List<dynamic> response = await api.fetchEntities();
    log(response.toString());
    return response.map((data) => Patient.fromJson(data)).toList();
  }

  @override
  Future<Patient> fetchEntity(int id) async {
    dynamic response = await api.fetchAnEntity(id);

    return Patient.fromJson(response);
  }
}
