import 'package:avicenna_app/application/time_slot/time_slot_bloc.dart';
import 'package:avicenna_app/domain/entries/doctor/doctor.dart';
import 'package:avicenna_app/domain/entries/time_slot/time_slot.dart';
import 'package:avicenna_app/domain/entries/user.dart';
import 'package:avicenna_app/presentation/constants/api_constant.dart';

import 'package:avicenna_app/presentation/constants/colors.dart';
import 'package:avicenna_app/presentation/helpers/on_boarding_helper.dart';

import 'package:avicenna_app/presentation/features/time_stamp/widgets/create_timestamp_bottom_sheet.dart';
import 'package:avicenna_app/presentation/features/time_stamp/widgets/time_stamp_detail_widget.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';

class SchedulesPage extends StatefulWidget {
  final AbstractUser user;
  const SchedulesPage({super.key, required this.user});

  @override
  State<SchedulesPage> createState() => _SchedulesPageState();
}

class _SchedulesPageState extends State<SchedulesPage> {
  bool showWeekView = false;
  late TimeSlotBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = TimeSlotBloc();
    bloc.add(GetUserTimeSlots());
    if (ApiConstants.isTheFirstTimeAppLaunch) {
      Future.delayed(
        const Duration(milliseconds: 500),
        () => OnBoardingHelper.doctorTutorial.show(context: context),
      );
    }
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc..add(GetUserTimeSlots()),
      child: CalendarControllerProvider<TimeSlot>(
        controller: EventController(),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(AppLocalizations.of(context)!.schedules),
            leading: IconButton(
              icon: Icon(
                showWeekView
                    ? Icons.calendar_view_week_rounded
                    : Icons.calendar_view_day_rounded,
              ),
              onPressed: () => setState(() {
                showWeekView = !showWeekView;
              }),
            ),
            actions: [
              if (widget.user is Doctor)
                IconButton(
                    key: OnBoardingHelper.doctorKeys[1],
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
                CalendarControllerProvider.of<TimeSlot>(context)
                    .controller
                    .removeWhere((element) => true);
                CalendarControllerProvider.of<TimeSlot>(context)
                    .controller
                    .addAll(state.timeSlots
                        .map(
                          (e) => CalendarEventData<TimeSlot>(
                            startTime: e.day.add(Duration(
                                hours: e.beginning.hour,
                                minutes: e.beginning.minute)),
                            endTime: e.day.add(Duration(
                                hours: e.end.hour, minutes: e.end.minute)),
                            date: e.day,
                            title: "Appointment",
                            event: e,
                            endDate: e.day,
                            description: e.id.toString(),
                            color: e.isConfirmed! && !e.isCancelled!
                                ? AppColors.primary
                                : e.isCancelled!
                                    ? AppColors.warning.withOpacity(0.4)
                                    : AppColors.primaryPale,
                          ),
                        )
                        .toList());
              }
              if (showWeekView) {
                return WeekView<TimeSlot>(
                  initialDay: DateTime.now(),
                  showWeekends: false,
                  showLiveTimeLineInAllDays: false,
                  headerStyle: HeaderStyle(
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.2),
                    ),
                  ),
                  liveTimeIndicatorSettings:
                      const HourIndicatorSettings(color: AppColors.primary),
                  onEventTap: (events, date) {
                    if (!events.first.event!.isCancelled!) {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Provider.value(
                            value: bloc,
                            child: TimeStampDetailWidget(
                              events: events,
                              abstractUser: widget.user,
                            ),
                          );
                        },
                      );
                    }
                  },
                );
              } else {
                return DayView<TimeSlot>(
                  initialDay: DateTime.now(),
                  // showLiveTimeLineInAllDays: false,
                  headerStyle: HeaderStyle(
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.2),
                    ),
                  ),
                  liveTimeIndicatorSettings:
                      const HourIndicatorSettings(color: AppColors.primary),
                  onEventTap: (events, date) {
                    if (!events.first.event!.isCancelled!) {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Provider.value(
                            value: bloc,
                            child: TimeStampDetailWidget(
                              events: events,
                              abstractUser: widget.user,
                            ),
                          );
                        },
                      );
                    }
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
