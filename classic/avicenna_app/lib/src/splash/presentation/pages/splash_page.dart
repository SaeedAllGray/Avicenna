import 'package:avicenna_app/src/auth/presentation/pages/login_page.dart';
import 'package:avicenna_app/src/constants/colors.dart';
import 'package:avicenna_app/src/home/home.dart';
import 'package:avicenna_app/src/splash/bloc/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(CheckUserEvent()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is UserExistsState) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          } else {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          }
        },
        child: const Scaffold(
          backgroundColor: AppColors.primary,
        ),
      ),
    );
  }
}
