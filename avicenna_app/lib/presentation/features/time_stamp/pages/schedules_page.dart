import 'package:avicenna_app/application/time_slot/time_slot_bloc.dart';
import 'package:avicenna_app/domain/entries/time_slot/time_slot.dart';
import 'package:avicenna_app/presentation/constants/colors.dart';

import 'package:avicenna_app/presentation/features/time_stamp/widgets/create_timestamp_bottom_sheet.dart';
import 'package:avicenna_app/presentation/features/time_stamp/widgets/time_stamp_detail_widget.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';

class SchedulesPage extends StatefulWidget {
  const SchedulesPage({super.key});

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
      child: CalendarControllerProvider<TimeSlot>(
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
                CalendarControllerProvider.of<TimeSlot>(context)
                    .controller
                    .addAll(state.timeSlots
                        .map(
                          (e) => CalendarEventData<TimeSlot>(
                            startTime: e.start,
                            endTime: e.end,
                            date: e.date,
                            title: "doctor.firstName",
                            event: e,
                            endDate: e.end,
                            description: e.id.toString(),
                            color: e.confirmed
                                ? AppColors.primary
                                : AppColors.primaryPale,
                          ),
                        )
                        .toList());
              }
              return WeekView<TimeSlot>(
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
                      return TimeStampDetailWidget(
                        events: events,
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
