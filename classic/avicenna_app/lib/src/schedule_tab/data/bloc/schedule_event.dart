part of 'schedule_bloc.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object> get props => [];
}

class GetScheduleEvent extends ScheduleEvent {
  final String uuid = const Uuid().v4();

  @override
  List<Object> get props => [uuid];
}

class DeleteSchedule extends ScheduleEvent {
  final Appointment appointment;

  const DeleteSchedule(this.appointment);
  @override
  List<Object> get props => [appointment];
}
