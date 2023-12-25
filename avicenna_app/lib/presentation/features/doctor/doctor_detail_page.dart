import 'package:avicenna_app/domain/entries/doctor/doctor.dart';
import 'package:avicenna_app/presentation/constants/colors.dart';
import 'package:avicenna_app/presentation/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:intl/intl.dart';

class DoctorDetailsPage extends StatelessWidget {
  final Doctor doctor;
  // final DoctorDetailBloc _bloc = DoctorDetailBloc();

  DoctorDetailsPage({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.white),
              child: Column(children: [
                Text(
                  '${doctor.firstName} ${doctor.lastName}',
                  style: FontStyles.BLACK_MEDIUM_24,
                ),
                Text(
                  doctor.specialization,
                  style: FontStyles.BLACK_REGULAR_18,
                ),
              ]),
            ),
            const SizedBox(
              height: 5,
            ),
            ListTile(
              tileColor: AppColors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Text(AppLocalizations.of(context)!.address),
              leading: const Icon(Icons.work),
              subtitle: Text(
                doctor.address,
                style: FontStyles.BLACK_REGULAR_18,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            ListTile(
              tileColor: AppColors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Text(AppLocalizations.of(context)!.email),
              leading: const Icon(Icons.email),
              subtitle: Text(
                doctor.email,
                style: FontStyles.BLACK_REGULAR_18,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            ListTile(
              tileColor: AppColors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Text(AppLocalizations.of(context)!.phone),
              leading: const Icon(Icons.phone),
              subtitle: Text(
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
          ],
        ),
      ),
    );
  }
}
