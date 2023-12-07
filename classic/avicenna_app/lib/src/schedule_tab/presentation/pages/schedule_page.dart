import 'package:avicenna_app/src/schedule_tab/data/bloc/schedule_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Schedules"),
      ),
      body: BlocProvider(
        create: (context) => ScheduleBloc()..add(GetScheduleEvent()),
        child: BlocBuilder<ScheduleBloc, ScheduleState>(
          builder: (context, state) {
            if (state is ScheduleFetched) {
              return ListView.builder(
                itemCount: state.appointmentList.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    final Event event = Event(
                      location: state.appointmentList[index].doctor!.address,
                      startDate: state.appointmentList[index].datetime,
                      endDate: state.appointmentList[index].datetime
                          .add(const Duration(hours: 2)),
                      iosParams: const IOSParams(
                        reminder: Duration(
                            /* Ex. hours:1 */), // on iOS, you can set alarm notification after your event.
                      ),
                      androidParams: const AndroidParams(
                        emailInvites: [], // on Android, you can add invite emails to your event.
                      ),
                      title:
                          'Meeting with Dr. ${state.appointmentList[index].doctor!.lastname}',
                    );
                    Add2Calendar.addEvent2Cal(event);
                  },
                  leading: const Icon(Icons.event_available),
                  title: Text(DateFormat('EEEE, MMMM d, HH:mm')
                      .format(state.appointmentList[index].datetime)),
                  subtitle: Text(
                      state.appointmentList[index].doctor!.firstname +
                          " " +
                          state.appointmentList[index].doctor!.lastname),
                  trailing: IconButton(
                      onPressed: () => BlocProvider.of<ScheduleBloc>(context)
                          .add(DeleteSchedule(state.appointmentList[index])),
                      icon: const Icon(Icons.delete_forever)),
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

class BottomSheetModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 370,
      child: Column(
        children: [
          CupertinoButton(
            child: Text('Done'),
            onPressed: () {
              // BlocProvider.of<ScheduleBloc>(context).add(Dele);
              Navigator.pop(context);
            },
          ),
          Container(
            height: 300,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              initialDateTime: DateTime.now(),
              onDateTimeChanged: (DateTime newDateTime) {
                // Handle the selected date and time
              },
            ),
          ),
        ],
      ),
    );
  }
}
