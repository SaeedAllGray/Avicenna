import 'dart:async';

import 'package:avicenna_app/src/models/appointment.dart';
import 'package:avicenna_app/src/schedule_tab/data/repo/schedule_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc() : super(ScheduleNotFetched()) {
    on<GetScheduleEvent>(_onGetScheduleEvent);
    on<DeleteSchedule>(_onDeleteScheduleEvent);
  }

  FutureOr<void> _onGetScheduleEvent(
      GetScheduleEvent event, Emitter<ScheduleState> emit) async {
    emit(ScheduleFetchInProgress());
    ScheduleRepository scheduleRepository = ScheduleRepository();
    try {
      List<Appointment> appointmentList =
          await scheduleRepository.getSchedules();
      print(appointmentList);
      emit(ScheduleFetched(
        appointmentList: appointmentList,
      ));
    } catch (e) {
      print(e);
      emit(ScheduleFetched(
        appointmentList: const [],
      ));
    }
  }

  FutureOr<void> _onDeleteScheduleEvent(
      DeleteSchedule event, Emitter<ScheduleState> emit) async {
    ScheduleRepository scheduleRepository = ScheduleRepository();
    //bool delettionSucceed =
    await scheduleRepository.deleteSchedule(event.appointment);
    if (state is ScheduleFetched) {
      (state as ScheduleFetched).appointmentList.remove(event.appointment);
      emit(ScheduleFetched(
        appointmentList: (state as ScheduleFetched).appointmentList,
      ));
    }
  }
}
