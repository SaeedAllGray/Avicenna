import 'package:avicenna_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:avicenna_app/src/auth/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthBloc _bloc = AuthBloc();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: _bloc,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('LOGIN'),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      label: Text('Email'),
                    ),
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(label: Text('Password')),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupPage())),
                          child: const Text("I AM A NEW USER")),
                      ElevatedButton(
                          onPressed: () => _bloc.add(LoginEvent()),
                          child: const Text("Login"))
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
