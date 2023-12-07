import 'package:avicenna_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:avicenna_app/src/auth/presentation/pages/signup_page.dart';
import 'package:avicenna_app/src/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthBloc _bloc = AuthBloc();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSucceedState) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
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
                        TextFormField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                            label: Text('Username'),
                          ),
                          onChanged: (v) => _bloc.add(InputEvent()),
                        ),
                        TextField(
                          obscureText: true,
                          controller: passwordController,
                          decoration:
                              const InputDecoration(label: Text('Password')),
                          onChanged: (v) => _bloc.add(InputEvent()),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        state is AuthInProgress
                            ? const Center(
                                child: CircularProgressIndicator.adaptive(),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SignupPage())),
                                      child: const Text("I AM A NEW USER")),
                                  ElevatedButton(
                                      onPressed: usernameController
                                                  .text.isNotEmpty &&
                                              passwordController.text.isNotEmpty
                                          ? () => _bloc.add(LoginEvent(
                                              usernameController.text,
                                              passwordController.text))
                                          : null,
                                      child: const Text("Login"))
                                ],
                              )
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}
