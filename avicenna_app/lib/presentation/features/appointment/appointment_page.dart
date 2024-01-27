import 'package:avicenna_app/application/patients/patients_bloc.dart';
import 'package:avicenna_app/application/time_slot/time_slot_bloc.dart';
import 'package:avicenna_app/domain/entries/time_slot/time_slot.dart';
import 'package:avicenna_app/domain/entries/user.dart';
import 'package:avicenna_app/presentation/constants/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppointmentPage extends StatefulWidget {
  final AbstractUser user;
  const AppointmentPage({super.key, required this.user});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimeSlotBloc()..add(const GetPendingTimeSlots()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.appointment),
        ),
        body: BlocBuilder<TimeSlotBloc, TimeSlotState>(
          builder: (context, state) {
            if (state is TimeSlotsFetched) {
              if (state.timeSlots.isEmpty) {
                return Center(
                  child: Text(AppLocalizations.of(context)!.no_request_message),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: state.timeSlots.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    tileColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: Text(
                        '${DateFormat('MMMM d').format(state.timeSlots[index].day)}, ${state.timeSlots[index].beginning.format(context)} - ${state.timeSlots[index].end.format(context)}'),
                    subtitle: Column(
                      children: [
                        BlocProvider(
                          create: (context) => PatientsBloc()
                            ..add(GetPatientDetails(
                                state.timeSlots[index].patientId!)),
                          child: BlocBuilder<PatientsBloc, PatientsState>(
                            builder: (context, state) {
                              if (state is PatientDetailsFetched) {
                                return ListTile(
                                  leading: const Icon(Icons.medical_services),
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    '${state.patient.user.firstName} ${state.patient.user.lastName}',
                                    textAlign: TextAlign.start,
                                  ),
                                );
                              }
                              return const LinearProgressIndicator();
                            },
                          ),
                        ),
                        Row(children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: AppColors.warning),
                              onPressed: () {
                                TimeSlot timeSlot = state.timeSlots[index];
                                timeSlot.isCancelled = true;
                                BlocProvider.of<TimeSlotBloc>(context)
                                    .add(UpdateTimeSlot(timeSlot: timeSlot));
                                BlocProvider.of<TimeSlotBloc>(context)
                                    .add(const GetPendingTimeSlots());
                              },
                              child: Text(
                                AppLocalizations.of(context)!.decline,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: AppColors.primary,
                              ),
                              onPressed: () {
                                TimeSlot timeSlot = state.timeSlots[index];
                                timeSlot.isConfirmed = true;
                                BlocProvider.of<TimeSlotBloc>(context)
                                    .add(UpdateTimeSlot(timeSlot: timeSlot));
                                BlocProvider.of<TimeSlotBloc>(context)
                                    .add(const GetPendingTimeSlots());
                              },
                              child: Text(
                                AppLocalizations.of(context)!.accept,
                              ),
                            ),
                          )
                        ]),
                      ],
                    ),
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
        ),
      ),
    );
  }
}
