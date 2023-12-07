import 'package:avicenna/domain/entries/doctor.dart';
import 'package:avicenna/domain/repositories/entity_repository.dart';
import 'package:avicenna/infrastructure/data_sources/doctor_data_source.dart';

class DoctorRepository extends EntityRepository<Doctor> {
  DoctorRepository(DoctorDataSource dataSource) : super(dataSource);

  @override
  Future<List<Doctor>> getAll() async {
    return await dataSource.fetchData();
  }

  @override
  Future<Doctor?> getById(String id) async {
    return await dataSource.fetchDataById(id);
  }

  @override
  Future<void> create(Doctor entity) async {}

  @override
  Future<void> update(String id, Doctor updatedEntity) async {
    await dataSource.update(id, updatedEntity);
  }

  @override
  Future<void> delete(String id) async {
    await dataSource.delete(id);
  }
}
