import 'package:avicenna_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatefulWidget {
  AuthPage({super.key});

  final AuthBloc _bloc = AuthBloc();
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
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
                  decoration: const InputDecoration(label: Text('Email')),
                ),
                ElevatedButton(
                    onPressed: () => _bloc.add(LoginEvent()),
                    child: const Text("Login"))
              ],
            )),
          ),
        );
      },
    );
  }
}
