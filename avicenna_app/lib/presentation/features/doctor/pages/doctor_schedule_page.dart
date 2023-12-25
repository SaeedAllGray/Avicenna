import 'package:avicenna_app/application/time_slot/time_slot_bloc.dart';
import 'package:avicenna_app/presentation/constants/fonts.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DoctorSchedulePage extends StatelessWidget {
  const DoctorSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController(),
      child: BlocProvider(
        create: (context) => TimeSlotBloc()..add(GetTimeSlots()),
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.available_time_slots),
          ),
          body: SafeArea(
            child: BlocBuilder<TimeSlotBloc, TimeSlotState>(
              builder: (context, state) {
                if (state is TimeSlotsFetched) {
                  CalendarControllerProvider.of(context)
                      .controller
                      .addAll(state.timeSlots
                          .map((e) => CalendarEventData(
                                startTime: e.start,
                                endTime: e.end,
                                date: e.date,
                                title: "hehe",
                              ))
                          .toList());
                  return WeekView(
                    onEventTap: (events, date) {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 400,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Text('Modal BottomSheet'),
                                  ElevatedButton(
                                    child: const Text('Close BottomSheet'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
