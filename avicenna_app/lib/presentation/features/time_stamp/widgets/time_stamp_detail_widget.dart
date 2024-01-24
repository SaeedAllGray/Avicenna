import 'dart:io';
import 'package:avicenna_app/application/doctors/doctors_bloc.dart';
import 'package:avicenna_app/application/patients/patients_bloc.dart';
import 'package:avicenna_app/application/time_slot/time_slot_bloc.dart';
import 'package:avicenna_app/domain/entries/doctor/doctor.dart';
import 'package:avicenna_app/domain/entries/patient/patient.dart';
import 'package:avicenna_app/domain/entries/time_slot/time_slot.dart';
import 'package:avicenna_app/domain/entries/user.dart';
import 'package:avicenna_app/presentation/constants/colors.dart';
import 'package:avicenna_app/presentation/constants/fonts.dart';
import 'package:avicenna_app/presentation/helpers/device_calendar_helper.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class TimeStampDetailWidget extends StatelessWidget {
  final List<CalendarEventData<TimeSlot>> events;
  final AbstractUser abstractUser;
  const TimeStampDetailWidget(
      {super.key, required this.events, required this.abstractUser});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Text(
              //   '${doctor.firstName} ${doctor.lastName}',
              //   style: FontStyles.BLACK_BOLD_24,
              // ),
              // Text(
              //   doctor.specialization,
              //   style: FontStyles.BLACK_REGULAR_18,
              // ),

              //  When the current user is patient, fetch doctor's info
              if (AbstractUser is Patient)
                BlocProvider(
                  create: (context) => DoctorsBloc()
                    ..add(GetDoctorDetails(events.first.event!.doctorId!)),
                  child: BlocBuilder<DoctorsBloc, DoctorsState>(
                    builder: (context, state) {
                      if (state is DoctorDetailsFetched) {
                        return Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.calendar_month),
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                DateFormat('MMMM d', Platform.localeName)
                                    .format(events.first.startTime!),
                                textAlign: TextAlign.start,
                              ),
                              subtitle: Text(
                                '${DateFormat('HH:mm', Platform.localeName).format(events.first.startTime!)} to ${DateFormat('HH:mm', Platform.localeName).format(events.first.endTime!)}',
                                textAlign: TextAlign.start,
                              ),
                              trailing: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: Text(AppLocalizations.of(context)!
                                      .add_to_calendar),
                                  onPressed: () {
                                    DeviceCalendarHelper
                                        .addToCalendarForPatient(
                                            events.first, state.doctor);
                                  }),
                            ),
                            ListTile(
                              leading: const Icon(Icons.medical_services),
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                'Dr. ${state.doctor.user.firstName} ${state.doctor.user.lastName}',
                                textAlign: TextAlign.start,
                              ),
                              subtitle: Text(state.doctor.specialization),
                              trailing: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child:
                                      Text(AppLocalizations.of(context)!.rate),
                                  onPressed: () {
                                    // TODO: Feedback UI and logic
                                  }),
                            ),
                          ],
                        );
                      }
                      return const LinearProgressIndicator();
                    },
                  ),
                ),
              // When the current user is doctor, fetch patient's info
              if (abstractUser is Doctor &&
                  events.first.event!.patientId != null)
                BlocProvider(
                  create: (context) => PatientsBloc()
                    ..add(GetPatientDetails(events.first.event!.patientId!)),
                  child: BlocBuilder<PatientsBloc, PatientsState>(
                    builder: (context, state) {
                      if (state is PatientDetailsFetched) {
                        return Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.calendar_month),
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                DateFormat('MMMM d', Platform.localeName)
                                    .format(events.first.startTime!),
                                textAlign: TextAlign.start,
                              ),
                              subtitle: Text(
                                '${DateFormat('HH:mm', Platform.localeName).format(events.first.startTime!)} to ${DateFormat('HH:mm', Platform.localeName).format(events.first.endTime!)}',
                                textAlign: TextAlign.start,
                              ),
                              trailing: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: Text(AppLocalizations.of(context)!
                                      .add_to_calendar),
                                  onPressed: () {
                                    DeviceCalendarHelper.addToCalendarForDoctor(
                                        eventData: events.first,
                                        patient: state.patient);
                                  }),
                            ),
                            ListTile(
                              leading: const Icon(Icons.medical_services),
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                '${state.patient.user.firstName} ${state.patient.user.lastName}',
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        );
                      }
                      return const LinearProgressIndicator();
                    },
                  ),
                ),
              if (abstractUser is Doctor &&
                  events.first.event!.patientId == null)
                ListTile(
                  leading: const Icon(Icons.calendar_month),
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    DateFormat('MMMM d', Platform.localeName)
                        .format(events.first.startTime!),
                    textAlign: TextAlign.start,
                  ),
                  subtitle: Text(
                    '${DateFormat('HH:mm', Platform.localeName).format(events.first.startTime!)} to ${DateFormat('HH:mm', Platform.localeName).format(events.first.endTime!)}',
                    textAlign: TextAlign.start,
                  ),
                  trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child:
                          Text(AppLocalizations.of(context)!.add_to_calendar),
                      onPressed: () {
                        DeviceCalendarHelper.addToCalendarForDoctor(
                            eventData: events.first);
                      }),
                ),
              // Options for the doctor: cancel/confirm the time stamp
              // options for the patient: cancel the time stamp
              const Spacer(),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.warning,
                    side: const BorderSide(color: AppColors.warning)),
                child: Text(AppLocalizations.of(context)!.cancel_appointment),
                onPressed: () {
                  TimeSlot timeSlot = events.first.event!;
                  timeSlot.isCancelled = true;
                  BlocProvider.of<TimeSlotBloc>(context).add(
                    UpdateTimeSlot(
                      timeSlot: timeSlot,
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        AppLocalizations.of(context)!
                            .appointment_cancelation_message,
                      ),
                    ),
                  );
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
