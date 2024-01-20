import 'package:avicenna_app/application/time_slot/time_slot_bloc.dart';
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
      create: (context) =>
          TimeSlotBloc()..add(const GetBookedTimeSlots(doctorId: 1)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.appointment),
        ),
        body: BlocBuilder<TimeSlotBloc, TimeSlotState>(
          builder: (context, state) {
            if (state is TimeSlotsFetched) {
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: state.timeSlots.length,
                itemBuilder: (context, indext) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    tileColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    subtitle: Text(
                        '${state.timeSlots[indext].beginning.format(context)} - ${state.timeSlots[indext].end.format(context)}'),
                    trailing: SizedBox(
                      width: 80,
                      child: Row(children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.close),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.check),
                        ),
                      ]),
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
