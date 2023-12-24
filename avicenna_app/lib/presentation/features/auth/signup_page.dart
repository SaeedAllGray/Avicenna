import 'package:avicenna_app/presentation/features/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool? isChecked = false;
  // final SignupBloc _bloc = SignupBloc();
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
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.register),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ListTile(
                title: Text(AppLocalizations.of(context)!.iAmADoctor),
                trailing: Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) => setState(() => isChecked = value),
                ),
              ),
              ListTile(
                title: TextField(
                  controller: firstNameController,
                  decoration: const InputDecoration(label: Text('First Name')),
                ),
              ),
              ListTile(
                title: TextField(
                  controller: lastNameController,
                  decoration: const InputDecoration(label: Text('Last Name')),
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
                    decoration: const InputDecoration(label: Text('Address')),
                  ),
                ),
              ),
              ListTile(
                title: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(label: Text('Username')),
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
                  decoration: const InputDecoration(label: Text('Password')),
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
                    child: Text(
                      AppLocalizations.of(context)!.iHaveAnAccount,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (isChecked != null && isChecked!) {
                          // _bloc.add(SignUpDoctorEvent(
                          //     Doctor(
                          //       firstname: firstNameController.text,
                          //       lastname: lastNameController.text,
                          //       address: addressController.text,
                          //       email: emailController.text,
                          //       isDoctor: true,
                          //       phoneNumber: phoneController.text,
                          //       profession: professionController.text,
                          //       username: usernameController.text,
                          //       id: 0,
                          //     ),
                          //     passwordController.text));
                        } else {
                          // _bloc.add(SignUpPatientEvent(
                          //     Patient(
                          //       firstname: firstNameController.text,
                          //       lastname: lastNameController.text,
                          //       email: emailController.text,
                          //       isDoctor: true,
                          //       socialSecurityNumber:
                          //           ssnController.text,
                          //       username: usernameController.text,
                          //       id: 0,
                          //     ),
                          //     passwordController.text));
                        }
                      },
                      child: Text(AppLocalizations.of(context)!.register)),
                ],
              ),
              // BlocBuilder<SignupBloc, SignupState>(
              //   builder: (context, state) {
              //     if (state is SignupInProgress) {
              //       return CircularProgressIndicator.adaptive();
              //     }

              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}
