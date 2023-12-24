// import 'dart:async';

// import 'package:avicenna_app/domain/entries/doctor.dart';
// import 'package:avicenna_app/domain/entries/patient.dart';
// import 'package:avicenna_app/src/auth/data/providers/signup_api.dart';
// import 'package:avicenna_app/src/auth/data/repo/auth_repository.dart';
// import 'package:avicenna_app/src/models/doctor.dart';
// import 'package:avicenna_app/src/models/patient.dart';
// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';

// part 'signup_event.dart';
// part 'signup_state.dart';

// class SignupBloc extends Bloc<SignupEvent, SignupState> {
//   SignupBloc() : super(SignupInitial()) {
//     on<SignUpDoctorEvent>(_onSignUpDoctorEvent);
//     on<SignUpPatientEvent>(_onSignUpPatientEvent);
//   }
//   FutureOr<void> _onSignUpPatientEvent(
//       SignUpPatientEvent event, Emitter<SignupState> emit) async {
//     emit(SignupInProgress());

//     if (await SignupApi().signUpPatient(event.patient, event.password)) {
//       await AuthRepository().login(event.patient.username, event.password);
//       emit(SignupSucceed());
//     } else {
//       emit(SignupFailed());
//     }
//   }

//   FutureOr<void> _onSignUpDoctorEvent(
//       SignUpDoctorEvent event, Emitter<SignupState> emit) async {
//     emit(SignupInProgress());

//     if (await SignupApi().signUpDoctor(event.doctor, event.password)) {
//       await AuthRepository().login(event.doctor.username, event.password);
//       emit(SignupSucceed());
//     } else {
//       emit(SignupFailed());
//     }
//   }
// }
