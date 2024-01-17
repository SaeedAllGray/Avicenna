import 'dart:convert';

import 'package:avicenna_app/infrastructure/data_sources/remote/remote_data_source.dart';
import 'package:avicenna_app/presentation/constants/api_constant.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DoctorRemoteDataSource implements RemoteDataSource {
  @override
  String url = ApiConstants.DOCTOR;
  Dio dio = Dio();

  @override
  Future<List<dynamic>> fetchEntities() async {
    // TODO: implement dynamic token
    dio.interceptors.add(PrettyDioLogger());
    Response response = await dio.get('${ApiConstants.baseUrl}$url',
        options: Options(headers: {
          'Authorization': 'Token dcee07d8713c07984e33ef33a17c67ac012cbb1b'
        }));

    // return response.data;
//     String mockresponse = '''[
//   {
//     "id": 1,
//     "first_name": "Dr. John",
//     "last_name": "Smith",
//     "specialization": "Cardiology",
//     "username": "johnsmith",
//     "email": "johnsmith@example.com",
//     "phone_number": "123-456-7890",
//     "address": "123 Medical Avenue, City, Country"
//   },
//   {
//     "id": 2,
//     "first_name": "Dr. Sarah",
//     "last_name": "Johnson",
//     "specialization": "Dermatology",
//     "username": "sarahj",
//     "email": "sarah.j@example.com",
//     "phone_number": "987-654-3210",
//     "address": "456 Dermatology Street, Town, Country"
//   },
//   {
//     "id": 3,
//     "first_name": "Dr. Michael",
//     "last_name": "Brown",
//     "specialization": "Pediatrics",
//     "username": "mbrown",
//     "email": "michaelbrown@example.com",
//     "phone_number": "555-123-4567",
//     "address": "789 Pediatric Lane, City, Country"
//   },
//   {
//     "id": 4,
//     "first_name": "Dr. Emily",
//     "last_name": "Jones",
//     "specialization": "Neurology",
//     "username": "emilyj",
//     "email": "emilyjones@example.com",
//     "phone_number": "111-222-3333",
//     "address": "987 Oncology Road, Town, Country"
//   },
//   {
//     "id": 5,
//     "first_name": "Dr. David",
//     "last_name": "Williams",
//     "specialization": "Orthopedics",
//     "username": "davidw",
//     "email": "davidwilliams@example.com",
//     "phone_number": "444-555-6666",
//     "address": "654 Orthopedics Avenue, City, Country"
//   },
//   {
//     "id": 6,
//     "first_name": "Dr. Samantha",
//     "last_name": "Miller",
//     "specialization": "Neurology",
//     "username": "samantham",
//     "email": "samanthamiller@example.com",
//     "phone_number": "777-888-9999",
//     "address": "321 Neurology Street, Town, Country"
//   },
//   {
//     "id": 7,
//     "first_name": "Dr. Benjamin",
//     "last_name": "Davis",
//     "specialization": "Gastroenterology",
//     "username": "benjamind",
//     "email": "benjamindavis@example.com",
//     "phone_number": "222-333-4444",
//     "address": "111 Gastroenterology Lane, City, Country"
//   },
//   {
//     "id": 8,
//     "first_name": "Dr. Olivia",
//     "last_name": "Garcia",
//     "specialization": "Endocrinology",
//     "username": "oliviag",
//     "email": "oliviagarcia@example.com",
//     "phone_number": "888-999-0000",
//     "address": "876 Endocrinology Road, Town, Country"
//   },
//   {
//     "id": 9,
//     "first_name": "Dr. Ethan",
//     "last_name": "Martinez",
//     "specialization": "Neurology",
//     "username": "ethanm",
//     "email": "ethanmartinez@example.com",
//     "phone_number": "666-777-8888",
//     "address": "543 Psychiatry Avenue, City, Country"
//   },
//   {
//     "id": 10,
//     "first_name": "Dr. Ava",
//     "last_name": "Lopez",
//     "specialization": "Rheumatology",
//     "username": "aval",
//     "email": "avalopez@example.com",
//     "phone_number": "333-444-5555",
//     "address": "210 Rheumatology Street, Town, Country"
//   },
//   {
//     "id": 11,
//     "first_name": "Dr. Aiden",
//     "last_name": "Hernandez",
//     "specialization": "Dentistry",
//     "username": "aidenh",
//     "email": "aidenhernandez@example.com",
//     "phone_number": "999-000-1111",
//     "address": "789 Dentistry Lane, City, Country"
//   },
//   {
//     "id": 12,
//     "first_name": "Dr. Mia",
//     "last_name": "Robinson",
//     "specialization": "Ophthalmology",
//     "username": "miar",
//     "email": "miarobinson@example.com",
//     "phone_number": "222-111-4444",
//     "address": "654 Ophthalmology Road, Town, Country"
//   },
//   {
//     "id": 13,
//     "first_name": "Dr. James",
//     "last_name": "Perez",
//     "specialization": "Urology",
//     "username": "jamesp",
//     "email": "jamesperez@example.com",
//     "phone_number": "777-888-5555",
//     "address": "321 Urology Avenue, City, Country"
//   },
//   {
//     "id": 14,
//     "first_name": "Dr. Charlotte",
//     "last_name": "Nguyen",
//     "specialization": "Allergy & Immunology",
//     "username": "charlotten",
//     "email": "charlottenguyen@example.com",
//     "phone_number": "444-555-2222",
//     "address": "987 Allergy Lane, Town, Country"
//   },
//   {
//     "id": 15,
//     "first_name": "Dr. Logan",
//     "last_name": "Kim",
//     "specialization": "Pulmonology",
//     "username": "logank",
//     "email": "logankim@example.com",
//     "phone_number": "111-222-3333",
//     "address": "456 Pulmonology Street, City, Country"
//   }
// ]
// ''';
    // print(jsonDecode(mockresponse));
    return response.data['results'];
  }

  @override
  Future fetchAnEntity(int id) async {
    // Response response = await dio.get(
    //   '${ApiConstants.baseUrl}/$url/$id',
    // );
    String mockdata = '''{
      "id": 3,
      "first_name": "Dr. Michael",
      "last_name": "Brown",
      "specialization": "Pediatrics",
      "username": "mbrown",
      "email": "michaelbrown@example.com",
      "phone_number": "555-123-4567",
      "address": "789 Pediatric Lane, City, Country"
    }''';
    return jsonDecode(mockdata);
  }
}
