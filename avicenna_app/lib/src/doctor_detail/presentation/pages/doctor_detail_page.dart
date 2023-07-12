import 'package:avicenna_app/src/constants/fonts.dart';
import 'package:avicenna_app/src/models/doctor.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class DoctorDetailsPage extends StatelessWidget {
  final Doctor doctor;

  const DoctorDetailsPage({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 30,
              child: Icon(Icons.person),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              '${doctor.firstname} ${doctor.lastname}',
              style: FontStyles.BLACK_MEDIUM_24,
            ),
            Text(
              doctor.profession,
              style: FontStyles.BLACK_REGULAR_18,
            ),
            ListTile(
              leading: const Icon(Icons.work),
              title: Text(
                doctor.address,
                style: FontStyles.BLACK_REGULAR_18,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: Text(
                doctor.email,
                style: FontStyles.BLACK_REGULAR_18,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: Text(
                doctor.phoneNumber,
                style: FontStyles.BLACK_REGULAR_18,
              ),
            ),
            const SizedBox(height: 16.0),
            const SizedBox(
              width: double.infinity,
              child: Text(
                'Schedules:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: doctor.schedules.length,
                itemBuilder: (context, index) {
                  DateTime schedule = doctor.schedules[index];
                  return ListTile(
                    title: Text(
                      DateFormat('EEEE, MMMM d, HH:mm').format(schedule),
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    trailing: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(shape: const CircleBorder()),
                      child: const Icon(Icons.add),
                      onPressed: () {},
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
