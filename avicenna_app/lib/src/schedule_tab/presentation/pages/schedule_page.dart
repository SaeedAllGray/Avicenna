import 'package:avicenna_app/src/schedule_tab/data/bloc/schedule_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduleBloc()..add(GetScheduleEvent()),
      child: BlocBuilder<ScheduleBloc, ScheduleState>(
        builder: (context, state) {
          if (state is ScheduleFetched) {
            return Scaffold(
              floatingActionButton: FloatingActionButton.extended(
                  onPressed: () {
                    final Event event = Event(
                      title: 'Event title',
                      description: 'Event description',
                      location: 'Event location',
                      startDate: DateTime.now().add(const Duration(days: 1)),
                      endDate:
                          DateTime.now().add(const Duration(days: 1, hours: 2)),
                      iosParams: const IOSParams(
                        reminder: Duration(
                            /* Ex. hours:1 */), // on iOS, you can set alarm notification after your event.
                        url:
                            'https://www.example.com', // on iOS, you can set url to your event.
                      ),
                      androidParams: const AndroidParams(
                        emailInvites: [], // on Android, you can add invite emails to your event.
                      ),
                    );
                    Add2Calendar.addEvent2Cal(event);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  label: const Text("Export to my calendar"),
                  icon: const Icon(Icons.event_note)),
              appBar: AppBar(
                title: const Text("My Schedules"),
                actions: [
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return BottomSheetModal();
                          },
                        );
                      },
                      icon: const Icon(Icons.add))
                ],
              ),
              body: ListView.builder(
                itemCount: state.appointmentList.length,
                itemBuilder: (context, index) => ListTile(
                  leading: const Icon(Icons.event_available),
                  title: Text(state.appointmentList[index].datetime.toString()),
                  subtitle: Text("Dr. Arthur Mohseni"),
                  trailing: IconButton(
                      onPressed: () => BlocProvider.of<ScheduleBloc>(context)
                          .add(DeleteSchedule(state.appointmentList[index])),
                      icon: const Icon(Icons.delete_forever)),
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
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
