import 'package:avicenna_app/domain/entries/doctor/doctor.dart';
import 'package:avicenna_app/presentation/constants/colors.dart';
import 'package:avicenna_app/presentation/constants/fonts.dart';
import 'package:avicenna_app/presentation/features/doctor/pages/doctor_schedule_page.dart';

import 'package:avicenna_app/presentation/features/doctor/widgets/feedbacks_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DoctorDetailsPage extends StatelessWidget {
  final Doctor doctor;
  // final DoctorDetailBloc _bloc = DoctorDetailBloc();

  const DoctorDetailsPage({super.key, required this.doctor});

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
                  '${doctor.user.firstName} ${doctor.user.lastName}',
                  style: FontStyles.BLACK_BOLD_24,
                ),
                Text(
                  doctor.specialization,
                  style: FontStyles.BLACK_BOLD_18,
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
                style: FontStyles.BLACK_BOLD_18,
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
                doctor.user.email,
                style: FontStyles.BLACK_BOLD_18,
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
                style: FontStyles.BLACK_BOLD_18,
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            DoctorSchedulePage(doctor: doctor),
                      ),
                    );
                  },
                  child:
                      Text(AppLocalizations.of(context)!.available_time_slots)),
            ),
            const SizedBox(
              height: 20,
            ),
            FeedbacksWidget(doctor: doctor),
          ],
        ),
      ),
    );
  }
}
