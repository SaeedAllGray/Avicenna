import 'package:avicenna_app/application/time_slot/time_slot_bloc.dart';
import 'package:avicenna_app/presentation/features/doctor/data/models/event_time_slot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DoctorSchedulePage extends StatelessWidget {
  const DoctorSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimeSlotBloc()..add(GetTimeSlots()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.available_time_slots),
        ),
        body: BlocBuilder<TimeSlotBloc, TimeSlotState>(
          builder: (context, state) {
            if (state is TimeSlotsFetched) {
              return SfCalendar(
                dataSource: EventTimeSlot(state.timeSlots),
                view: CalendarView.schedule,
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
