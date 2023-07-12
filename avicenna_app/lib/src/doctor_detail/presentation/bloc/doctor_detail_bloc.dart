import 'dart:async';

import 'package:avicenna_app/src/doctor_detail/data/provider/appointment_repository.dart';
import 'package:avicenna_app/src/models/appointment.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'doctor_detail_event.dart';
part 'doctor_detail_state.dart';

class DoctorDetailBloc extends Bloc<DoctorDetailEvent, DoctorDetailState> {
  DoctorDetailBloc() : super(DoctorDetailInitial()) {
    on<GetAllAppointments>(_onGetAllAppointments);
    on<MakeAppointment>(_onMakeAppointment);
  }

  FutureOr<void> _onGetAllAppointments(
      GetAllAppointments event, Emitter<DoctorDetailState> emit) async {
    emit(DoctorDetailInProgress());
    List<Appointment> appointments =
        await AppointmentRepository().getAllFreeAppointments();
    print(appointments);
    emit(DoctorDetailInFetched(appointments));
  }

  FutureOr<void> _onMakeAppointment(
      MakeAppointment event, Emitter<DoctorDetailState> emit) async {
    await AppointmentRepository()
        .makeAppointment(event.doctorId, event.dateTime);
    emit(AppointmentCreated());
    emit(DoctorDetailInProgress());
    List<Appointment> appointments =
        await AppointmentRepository().getAllFreeAppointments();
    print(appointments);
    emit(DoctorDetailInFetched(appointments));
  }
}
