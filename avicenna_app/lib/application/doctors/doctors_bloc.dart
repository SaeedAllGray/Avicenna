import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'doctors_event.dart';
part 'doctors_state.dart';

class DoctorsBloc extends Bloc<DoctorsEvent, DoctorsState> {
  DoctorsBloc() : super(DoctorsInitial()) {
    on<DoctorsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
