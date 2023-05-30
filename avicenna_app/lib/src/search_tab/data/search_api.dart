import 'package:avicenna_app/src/models/doctor.dart';
import 'package:faker/faker.dart';

class SearchApi {
  Future<List<Doctor>> fetchSearchResult(String searchTerm) async {
    await Future.delayed(const Duration(seconds: 2));
    List<String> realProfessions = [
      'Cardiologist',
      'Pediatrician',
      'Dermatologist',
      'Orthopedic Surgeon',
      'Neurologist',
      'Gynecologist',
      'Ophthalmologist',
      'Psychiatrist',
      // Add more real professions here...
    ];

    List<Doctor> doctors = [];

    for (int i = 1; i <= 100; i++) {
      Doctor doctor = Doctor(
        id: i.toString(),
        name: 'Dr. ${faker.person.firstName()} ${faker.person.lastName()}',
        email: faker.internet.email(),
        profession: realProfessions[i % realProfessions.length],
      );

      // Generate 4 schedules for each doctor
      for (int j = 0; j < 4; j++) {
        DateTime schedule = DateTime.now().add(Duration(days: j + 1));
        doctor.schedules.add(schedule);
      }

      doctors.add(doctor);
    }

    return doctors;
  }
}
