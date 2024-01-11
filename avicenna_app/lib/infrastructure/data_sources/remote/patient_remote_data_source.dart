import 'dart:convert';

import 'package:avicenna_app/infrastructure/data_sources/remote/remote_data_source.dart';

import 'package:dio/dio.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class PatientRemoteDataSource implements RemoteDataSource {
  @override
  String url = "patients";
  Dio dio = Dio();

  @override
  Future fetchAnEntity(int id) async {
    // TODO: implement fetchAnEntity
    String mockString = '''{ "id": 1,
  "ssn": "123-45-6789",
  "first_name": "John",
  "last_name": "Doe",
  "birth_date": "1950-12-26T14:00:00",
  "username": "johndoe123",
  "email": "johndoe@example.com"
}''';
    return jsonDecode(mockString);
  }

  @override
  Future fetchEntities() {
    // TODO: implement fetchEntities
    throw UnimplementedError();
  }
}
