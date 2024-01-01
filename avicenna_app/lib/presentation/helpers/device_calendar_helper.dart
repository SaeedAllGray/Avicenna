import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:avicenna_app/domain/entries/time_slot/time_slot.dart';
import 'package:calendar_view/calendar_view.dart';

class DeviceCalendarHelper {
  static void addToCalendarForPatient(CalendarEventData<TimeSlot> eventData) {
    final Event event = Event(
      startDate: eventData.startTime!,
      endDate: eventData.endTime!,
      iosParams: const IOSParams(
        reminder: Duration(/* Ex. hours:1 */),
      ),
      androidParams: const AndroidParams(
        emailInvites: [], // on Android, you can add invite emails to your event.
      ),
      title: 'Meeting with Dr. ',
    );
    Add2Calendar.addEvent2Cal(event);
  }

  // static void addToCalendarForDoctor(CalendarEventData<TimeSlot> eventData) {
  //   final Event event = Event(
  //     startDate: eventData.startTime!,
  //     endDate: eventData.endTime!,
  //     iosParams: const IOSParams(
  //       reminder: Duration(/* Ex. hours:1 */),
  //     ),
  //     androidParams: const AndroidParams(
  //       emailInvites: [], // on Android, you can add invite emails to your event.
  //     ),
  //     title: 'Meeting with Dr. ',
  //   );
  //   Add2Calendar.addEvent2Cal(event);
  // }
}
