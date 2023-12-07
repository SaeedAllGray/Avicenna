import 'package:avicenna/domain/entries/doctor.dart';
import 'package:avicenna/domain/value_objects/user_info.dart';
import 'package:avicenna/infrastructure/data_sources/entity_data_source.dart';

class DoctorDataSource implements EntityDataSource<Doctor> {
  // Implementation might involve interaction with an API, database, etc.
  // You'd typically inject dependencies such as HTTP client or database helper here

  @override
  Future<List<Doctor>> fetchData() async {
    // Example: Fetch doctors from an API or database
    // return await someApiService.fetchDoctors();
    // or return await databaseHelper.getAllDoctors();
    return [
      Doctor(
          userInfo:
              UserInfo(id: ',', firstName: '', lastName: '', userName: ''),
          specialization: 'specialization')
    ];
  }

  @override
  Future<Doctor> fetchDataById(String id) async {
    // Example: Get a doctor by ID from an API or database
    // return await someApiService.getDoctorById(id);
    // or return await databaseHelper.getDoctorById(id);
    return Doctor(
        userInfo: UserInfo(id: ',', firstName: '', lastName: '', userName: ''),
        specialization: 'specialization');
  }

  @override
  Future<Doctor> create(Doctor t) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Doctor> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Doctor> update(String id, Doctor t) {
    // TODO: implement update
    throw UnimplementedError();
  }

  // Other CRUD methods for doctors could be implemented here
}
