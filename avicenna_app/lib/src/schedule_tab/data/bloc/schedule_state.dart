part of 'schedule_bloc.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

class ScheduleNotFetched extends ScheduleState {}

class ScheduleFetched extends ScheduleState {
  final String uuid = const Uuid().v4();
  final List<Appointment> appointmentList;

  ScheduleFetched({required this.appointmentList});

  @override
  List<Object> get props => [appointmentList, uuid];
}

class ScheduleFetchInProgress extends ScheduleState {}

class ScheduleFetchFailed extends ScheduleState {}
