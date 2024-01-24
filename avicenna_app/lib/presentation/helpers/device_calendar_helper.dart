import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:avicenna_app/domain/entries/doctor/doctor.dart';
import 'package:avicenna_app/domain/entries/patient/patient.dart';
import 'package:avicenna_app/domain/entries/time_slot/time_slot.dart';
import 'package:calendar_view/calendar_view.dart';

class DeviceCalendarHelper {
  static void addToCalendarForPatient(
      CalendarEventData<TimeSlot> eventData, Doctor doctor) {
    final Event event = Event(
      startDate: eventData.startTime!,
      endDate: eventData.endTime!,
      location: doctor.address,
      description: doctor.phoneNumber,
      iosParams: const IOSParams(
        reminder: Duration(/* Ex. hours:1 */),
      ),
      androidParams: const AndroidParams(
        emailInvites: [], // on Android, you can add invite emails to your event.
      ),
      title:
          'Meeting with Dr. ${doctor.user.firstName} ${doctor.user.lastName}',
    );
    Add2Calendar.addEvent2Cal(event);
  }

  static void addToCalendarForDoctor(
      {required CalendarEventData<TimeSlot> eventData, Patient? patient}) {
    final Event event = Event(
      startDate: eventData.startTime!,
      endDate: eventData.endTime!,
      iosParams: const IOSParams(
        reminder: Duration(/* Ex. hours:1 */),
      ),
      androidParams: const AndroidParams(
        emailInvites: [], // on Android, you can add invite emails to your event.
      ),
      title: patient != null
          ? 'Meeting with ${patient.user.firstName} ${patient.user.lastName}'
          : "Empty Time Slot",
    );
    Add2Calendar.addEvent2Cal(event);
  }
}
