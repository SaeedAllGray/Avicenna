import 'dart:convert';

import 'package:avicenna_app/infrastructure/data_sources/remote/remote_data_source.dart';
import 'package:avicenna_app/presentation/constants/api_constant.dart';
import 'package:dio/dio.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class TimeSlotRemoteDataSource implements RemoteDataSource {
  @override
  String url = "time_slot";
  Dio dio = Dio();

  @override
  Future<List<dynamic>> fetchEntities() async {
    // dio.interceptors.add(PrettyDioLogger());
    // Response response = await dio.get(
    //   '${ApiConstants.baseUrl}/$url',
    // );

    // return response.data;
    String mockresponse = '''[
  {
    "id": 1,
    "date": "2023-12-24",
    "start": "2023-12-24T09:00:00",
    "end": "2023-12-24T10:00:00",
    "doctor_id": 101,
    "patient_id": 201,
    "confirmed": true
  },
  {
    "id": 2,
    "date": "2023-12-24",
    "start": "2023-12-24T11:00:00",
    "end": "2023-12-24T12:00:00",
    "doctor_id": 102,
    "patient_id": 202,
    "confirmed": true
  },
  {
    "id": 3,
    "date": "2023-12-26",
    "start": "2023-12-26T14:00:00",
    "end": "2023-12-26T15:00:00",
    "doctor_id": 103,
    "patient_id": 203,
    "confirmed": false
  },
  {
    "id": 4,
    "date": "2023-12-27",
    "start": "2023-12-27T08:00:00",
    "end": "2023-12-27T09:00:00",
    "doctor_id": 104,
    "patient_id": 204,
    "confirmed": true
  },
  {
    "id": 5,
    "date": "2023-12-28",
    "start": "2023-12-28T11:00:00",
    "end": "2023-12-28T12:00:00",
    "doctor_id": 105,
    "patient_id": 205,
    "confirmed": false
  },
  {
    "id": 6,
    "date": "2023-12-29",
    "start": "2023-12-29T09:30:00",
    "end": "2023-12-29T10:30:00",
    "doctor_id": 106,
    "patient_id": 206,
    "confirmed": true
  },
  {
    "id": 7,
    "date": "2023-12-30",
    "start": "2023-12-30T13:45:00",
    "end": "2023-12-30T14:45:00",
    "doctor_id": 107,
    "patient_id": 207,
    "confirmed": false
  },
  {
    "id": 8,
    "date": "2023-12-31",
    "start": "2023-12-31T16:20:00",
    "end": "2023-12-31T17:20:00",
    "doctor_id": 108,
    "patient_id": 208,
    "confirmed": true
  },
  {
    "id": 9,
    "date": "2024-01-01",
    "start": "2024-01-01T07:45:00",
    "end": "2024-01-01T08:45:00",
    "doctor_id": 109,
    "patient_id": 209,
    "confirmed": false
  },
  {
    "id": 10,
    "date": "2024-01-02",
    "start": "2024-01-02T12:15:00",
    "end": "2024-01-02T13:15:00",
    "doctor_id": 110,
    "patient_id": 210,
    "confirmed": true
  }
]

''';
    print(jsonDecode(mockresponse));
    return jsonDecode(mockresponse);
  }

  Future<List<dynamic>> fetchDoctorEntities(int doctorId) async {
    // dio.interceptors.add(PrettyDioLogger());
    // Response response = await dio.get(
    //   '${ApiConstants.baseUrl}/$url?doctor_id=$doctorId',
    // );

    // return response.data;
    String mockresponse = '''[
  {
    "id": 1,
    "date": "2023-12-24",
    "start": "2023-12-24T09:00:00",
    "end": "2023-12-24T10:00:00",
    "doctor_id": 101,
    "patient_id": 201,
    "confirmed": true
  },
  {
    "id": 2,
    "date": "2023-12-24",
    "start": "2023-12-24T11:00:00",
    "end": "2023-12-24T12:00:00",
    "doctor_id": 102,
    "patient_id": 202,
    "confirmed": true
  },
  {
    "id": 3,
    "date": "2023-12-26",
    "start": "2023-12-26T14:00:00",
    "end": "2023-12-26T15:00:00",
    "doctor_id": 103,
    "patient_id": 203,
    "confirmed": false
  },
  {
    "id": 4,
    "date": "2023-12-27",
    "start": "2023-12-27T08:00:00",
    "end": "2023-12-27T09:00:00",
    "doctor_id": 104,
    "patient_id": 204,
    "confirmed": true
  },
  {
    "id": 5,
    "date": "2023-12-28",
    "start": "2023-12-28T11:00:00",
    "end": "2023-12-28T12:00:00",
    "doctor_id": 105,
    "patient_id": 205,
    "confirmed": false
  },
  {
    "id": 6,
    "date": "2023-12-29",
    "start": "2023-12-29T09:30:00",
    "end": "2023-12-29T10:30:00",
    "doctor_id": 106,
    "patient_id": 206,
    "confirmed": true
  },
  {
    "id": 7,
    "date": "2023-12-30",
    "start": "2023-12-30T13:45:00",
    "end": "2023-12-30T14:45:00",
    "doctor_id": 107,
    "patient_id": 207,
    "confirmed": false
  },
  {
    "id": 8,
    "date": "2023-12-31",
    "start": "2023-12-31T16:20:00",
    "end": "2023-12-31T17:20:00",
    "doctor_id": 108,
    "patient_id": 208,
    "confirmed": true
  },
  {
    "id": 9,
    "date": "2024-01-01",
    "start": "2024-01-01T07:45:00",
    "end": "2024-01-01T08:45:00",
    "doctor_id": 109,
    "patient_id": 209,
    "confirmed": false
  },
  {
    "id": 10,
    "date": "2024-01-02",
    "start": "2024-01-02T12:15:00",
    "end": "2024-01-02T13:15:00",
    "doctor_id": 110,
    "patient_id": 210,
    "confirmed": true
  }
]

''';
    print(jsonDecode(mockresponse));
    return jsonDecode(mockresponse);
  }

  Future<List<dynamic>> fetchPatientEntities(int patientId) async {
    // dio.interceptors.add(PrettyDioLogger());
    // Response response = await dio.get(
    //   '${ApiConstants.baseUrl}/$url?patient_id=$patientId',
    // );

    // return response.data;
    String mockresponse = '''[
  {
    "id": 1,
    "date": "2023-12-24",
    "start": "2023-12-24T09:00:00",
    "end": "2023-12-24T10:00:00",
    "doctor_id": 101,
    "patient_id": 201,
    "confirmed": true
  },
  {
    "id": 2,
    "date": "2023-12-24",
    "start": "2023-12-24T11:00:00",
    "end": "2023-12-24T12:00:00",
    "doctor_id": 102,
    "patient_id": 202,
    "confirmed": true
  },
  {
    "id": 3,
    "date": "2023-12-26",
    "start": "2023-12-26T14:00:00",
    "end": "2023-12-26T15:00:00",
    "doctor_id": 103,
    "patient_id": 203,
    "confirmed": false
  },
  {
    "id": 4,
    "date": "2023-12-27",
    "start": "2023-12-27T08:00:00",
    "end": "2023-12-27T09:00:00",
    "doctor_id": 104,
    "patient_id": 204,
    "confirmed": true
  },
  {
    "id": 5,
    "date": "2023-12-28",
    "start": "2023-12-28T11:00:00",
    "end": "2023-12-28T12:00:00",
    "doctor_id": 105,
    "patient_id": 205,
    "confirmed": false
  },
  {
    "id": 6,
    "date": "2023-12-29",
    "start": "2023-12-29T09:30:00",
    "end": "2023-12-29T10:30:00",
    "doctor_id": 106,
    "patient_id": 206,
    "confirmed": true
  },
  {
    "id": 7,
    "date": "2023-12-30",
    "start": "2023-12-30T13:45:00",
    "end": "2023-12-30T14:45:00",
    "doctor_id": 107,
    "patient_id": 207,
    "confirmed": false
  },
  {
    "id": 8,
    "date": "2023-12-31",
    "start": "2023-12-31T16:20:00",
    "end": "2023-12-31T17:20:00",
    "doctor_id": 108,
    "patient_id": 208,
    "confirmed": true
  },
  {
    "id": 9,
    "date": "2024-01-01",
    "start": "2024-01-01T07:45:00",
    "end": "2024-01-01T08:45:00",
    "doctor_id": 109,
    "patient_id": 209,
    "confirmed": false
  },
  {
    "id": 10,
    "date": "2024-01-02",
    "start": "2024-01-02T12:15:00",
    "end": "2024-01-02T13:15:00",
    "doctor_id": 110,
    "patient_id": 210,
    "confirmed": true
  }
]

''';
    print(jsonDecode(mockresponse));
    return jsonDecode(mockresponse);
  }

  @override
  Future fetchAnEntity(int id) async {
    Response response = await dio.get(
      '${ApiConstants.baseUrl}/$url/$id',
    );
    return response.data;
  }
}
