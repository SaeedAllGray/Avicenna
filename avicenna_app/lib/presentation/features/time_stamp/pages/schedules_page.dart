import 'dart:io';

import 'package:avicenna_app/application/time_slot/time_slot_bloc.dart';
import 'package:avicenna_app/domain/entries/user.dart';
import 'package:avicenna_app/presentation/constants/colors.dart';
import 'package:avicenna_app/presentation/constants/fonts.dart';
import 'package:avicenna_app/presentation/features/time_stamp/widgets/create_timestamp_bottom_sheet.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SchedulesPage extends StatefulWidget {
  final User user;
  const SchedulesPage({super.key, required this.user});

  @override
  State<SchedulesPage> createState() => _SchedulesPageState();
}

class _SchedulesPageState extends State<SchedulesPage> {
  late TimeSlotBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = TimeSlotBloc();
    bloc.add(const GetDoctorTimeSlots(doctorId: 1));
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc..add(const GetDoctorTimeSlots(doctorId: 1)),
      child: CalendarControllerProvider(
        controller: EventController(),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(AppLocalizations.of(context)!.schedules),
            actions: [
              //TODO: the condition to check whether the user is a [doctor] or a [patient]

              IconButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext conte2xt) {
                        return Provider.value(
                          value: bloc,
                          child: const CreateTimeStampBottonSheet(),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.add_rounded))
            ],
          ),
          body: BlocBuilder<TimeSlotBloc, TimeSlotState>(
            builder: (context, state) {
              if (state is TimeSlotsFetched) {
                CalendarControllerProvider.of(context)
                    .controller
                    .addAll(state.timeSlots
                        .map(
                          (e) => CalendarEventData(
                              startTime: e.start,
                              endTime: e.end,
                              date: e.date,
                              title: "doctor.firstName",
                              event: e.start,
                              endDate: e.end,
                              color: AppColors.primary),
                        )
                        .toList());
              }
              return WeekView(
                headerStyle: HeaderStyle(
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.2),
                  ),
                ),
                liveTimeIndicatorSettings:
                    const HourIndicatorSettings(color: AppColors.primary),
                onEventTap: (events, date) {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 350,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 25),
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
                                ListTile(
                                  leading: const Icon(Icons.calendar_month),
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    DateFormat('MMMM d', Platform.localeName)
                                        .format(events.first.startTime!),
                                    style: FontStyles.BLACK_REGULAR_18,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                ListTile(
                                  leading: const Icon(Icons.alarm),
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    '${DateFormat('HH:mm', Platform.localeName).format(events.first.startTime!)} to ${DateFormat('HH:mm', Platform.localeName).format(events.first.endTime!)}',
                                    style: FontStyles.BLACK_REGULAR_18,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary),
                                  child: Text(AppLocalizations.of(context)!
                                      .make_appointment),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          AppLocalizations.of(context)!
                                              .appointment_confirmation_message,
                                        ),
                                      ),
                                    );
                                    Navigator.popUntil(
                                        context, (route) => route.isFirst);
                                  },
                                ),
                                TextButton(
                                  child: Text(AppLocalizations.of(context)!
                                      .choose_another_time),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
