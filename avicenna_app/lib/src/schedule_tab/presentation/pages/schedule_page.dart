import 'package:flutter/material.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            final Event event = Event(
              title: 'Event title',
              description: 'Event description',
              location: 'Event location',
              startDate: DateTime.now().add(const Duration(days: 1)),
              endDate: DateTime.now().add(const Duration(days: 1, hours: 2)),
              iosParams: IOSParams(
                reminder: Duration(
                    /* Ex. hours:1 */), // on iOS, you can set alarm notification after your event.
                url:
                    'https://www.example.com', // on iOS, you can set url to your event.
              ),
              androidParams: AndroidParams(
                emailInvites: [], // on Android, you can add invite emails to your event.
              ),
            );
            Add2Calendar.addEvent2Cal(event);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          label: const Text("Export to my calendar"),
          icon: const Icon(Icons.event_note)),
      appBar: AppBar(
        title: const Text("My Schedules"),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) => const ListTile(
          leading: Icon(Icons.event_available),
          title: Text("Thursday, July 6"),
          subtitle: Text("Dr. Arthur Mohseni"),
        ),
      ),
    );
  }
}
