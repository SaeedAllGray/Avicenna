import 'package:avicenna_app/domain/entries/time_slot/time_slot.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventTimeSlot extends CalendarDataSource {
  EventTimeSlot(List<TimeSlot> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].start;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].end;
  }

  @override
  String getSubject(int index) {
    return "Available";
  }

  @override
  Color getColor(int index) {
    return Colors.teal;
  }

  @override
  bool isAllDay(int index) {
    return false;
  }
}
