import 'package:avicenna_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:avicenna_app/src/auth/presentation/pages/login_page.dart';
import 'package:avicenna_app/src/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool? isChecked = false;
  final AuthBloc _bloc = AuthBloc();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ssnController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController professionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: _bloc,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('SIGN UP'),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  ListTile(
                    title: const Text("I am a doctor"),
                    trailing: Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) =>
                          setState(() => isChecked = value),
                    ),
                  ),
                  ListTile(
                    title: TextField(
                      controller: firstNameController,
                      decoration:
                          const InputDecoration(label: Text('First Name')),
                    ),
                  ),
                  ListTile(
                    title: TextField(
                      controller: lastNameController,
                      decoration:
                          const InputDecoration(label: Text('Last Name')),
                    ),
                  ),
                  Visibility(
                    visible: !isChecked!,
                    child: ListTile(
                      title: TextField(
                        keyboardType: TextInputType.number,
                        controller: ssnController,
                        decoration: const InputDecoration(
                            label: Text('Social Security Number')),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isChecked!,
                    child: ListTile(
                      title: TextField(
                        controller: professionController,
                        decoration:
                            const InputDecoration(label: Text('Profession')),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isChecked!,
                    child: ListTile(
                      title: TextField(
                        controller: phoneController,
                        decoration:
                            const InputDecoration(label: Text('Phone Number')),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isChecked!,
                    child: ListTile(
                      title: TextField(
                        controller: addressController,
                        decoration:
                            const InputDecoration(label: Text('Address')),
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextField(
                      controller: usernameController,
                      decoration:
                          const InputDecoration(label: Text('Username')),
                    ),
                  ),
                  ListTile(
                    title: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        label: Text('Email'),
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration:
                          const InputDecoration(label: Text('Password')),
                    ),
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
                                  builder: (context) => const LoginPage())),
                          child: const Text("I ALREADY HAVE AN ACCOUNT")),
                      ElevatedButton(
                          onPressed: () {
                            _bloc.add(SignupEvent());
                            // TODO: remove this
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          },
                          child: const Text("Signup")),
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
