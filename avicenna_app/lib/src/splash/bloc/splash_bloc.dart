import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(InitialState()) {
    on<SplashEvent>((event, emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getBool('is_signed_in') == null) {
        emit(UserDoesNotExistState());
      } else {
        emit(UserExistsState());
      }
    });
  }
}
