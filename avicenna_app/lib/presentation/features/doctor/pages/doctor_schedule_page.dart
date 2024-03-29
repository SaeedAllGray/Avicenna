import 'dart:io';

import 'package:avicenna_app/application/time_slot/time_slot_bloc.dart';
import 'package:avicenna_app/domain/entries/doctor/doctor.dart';
import 'package:avicenna_app/domain/entries/time_slot/time_slot.dart';
import 'package:avicenna_app/presentation/constants/colors.dart';
import 'package:avicenna_app/presentation/constants/fonts.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DoctorSchedulePage extends StatefulWidget {
  final Doctor doctor;
  const DoctorSchedulePage({super.key, required this.doctor});

  @override
  State<DoctorSchedulePage> createState() => _DoctorSchedulePageState();
}

class _DoctorSchedulePageState extends State<DoctorSchedulePage> {
  TimeSlotBloc bloc = TimeSlotBloc();
  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider<TimeSlot>(
      controller: EventController(),
      child: BlocProvider(
        create: (context) => bloc
          ..add(GetDoctorAvailableTimeSlots(doctorId: widget.doctor.user.id!)),
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.available_time_slots),
          ),
          body: BlocBuilder<TimeSlotBloc, TimeSlotState>(
            builder: (context, state) {
              if (state is TimeSlotsFetched) {
                CalendarControllerProvider.of<TimeSlot>(context)
                    .controller
                    .addAll(state.timeSlots
                        .where((element) => element.day.isAfter(
                            DateTime.now().subtract(const Duration(days: 1))))
                        .map(
                          (e) => CalendarEventData(
                              startTime: e.day.add(Duration(
                                  hours: e.beginning.hour,
                                  minutes: e.beginning.minute)),
                              endTime: e.day.add(Duration(
                                  hours: e.end.hour, minutes: e.end.minute)),
                              date: e.day,
                              title: "Free",
                              event: e,
                              endDate: e.day,
                              color: AppColors.primary),
                        )
                        .toList());
              }
              return WeekView<TimeSlot>(
                initialDay: DateTime.now(),
                showWeekends: false,
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
                      return Provider.value(
                        value: bloc,
                        child: SizedBox(
                          height: 350,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,

                                // mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    '${widget.doctor.user.firstName} ${widget.doctor.user.lastName}',
                                    style: FontStyles.BLACK_BOLD_24,
                                  ),
                                  Text(
                                    widget.doctor.specialization,
                                    style: FontStyles.BLACK_REGULAR_18,
                                  ),
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
                                      TimeSlot timeSlot = events.first.event!;

                                      bloc.add(
                                          ReserveTimeSlot(timeSlot: timeSlot));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
