import 'package:avicenna_app/application/auth/auth_bloc.dart';
import 'package:avicenna_app/presentation/constants/colors.dart';
import 'package:avicenna_app/presentation/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthBloc _bloc = AuthBloc();
  bool isChecked = false;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ssnController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController professionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSucceedState) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Scaffold()));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          bloc: _bloc,
          builder: (context, state) {
            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/avicenna.png',
                        height: 100,
                        color: Colors.teal,
                      ),
                      Text(
                        AppLocalizations.of(context)!.appTitle,
                        style: FontStyles.BLACK_MEDIUM_24,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Visibility(
                        visible: _bloc.signupActive,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                  AppLocalizations.of(context)!.iAmADoctor),
                              trailing: Checkbox(
                                value: isChecked,
                                onChanged: (bool? value) =>
                                    setState(() => isChecked = value!),
                              ),
                            ),
                            ListTile(
                              title: TextField(
                                controller: firstNameController,
                                decoration: InputDecoration(
                                    label: Text(AppLocalizations.of(context)!
                                        .firstName)),
                              ),
                            ),
                            ListTile(
                              title: TextField(
                                controller: lastNameController,
                                decoration: InputDecoration(
                                    label: Text(AppLocalizations.of(context)!
                                        .lastName)),
                              ),
                            ),
                            Visibility(
                              visible: !isChecked,
                              child: ListTile(
                                title: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: ssnController,
                                  decoration: InputDecoration(
                                    label: Text(AppLocalizations.of(context)!
                                        .socialNumber),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: isChecked,
                              child: ListTile(
                                title: TextField(
                                  controller: professionController,
                                  decoration: const InputDecoration(
                                      label: Text('Profession')),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: isChecked,
                              child: ListTile(
                                title: TextField(
                                  controller: phoneController,
                                  decoration: InputDecoration(
                                      label: Text(
                                          AppLocalizations.of(context)!.phone)),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: isChecked,
                              child: ListTile(
                                title: TextField(
                                  controller: addressController,
                                  decoration: InputDecoration(
                                    label: Text(
                                        AppLocalizations.of(context)!.address),
                                  ),
                                ),
                              ),
                            ),
                            ListTile(
                              title: TextField(
                                obscureText: true,
                                controller: emailController,
                                decoration: InputDecoration(
                                  label:
                                      Text(AppLocalizations.of(context)!.email),
                                ),
                                // onChanged: (v) => _bloc.add(InputEvent()),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: !_bloc.signupActive,
                        child: Column(
                          children: [
                            ListTile(
                              title: TextFormField(
                                controller: usernameController,
                                decoration: InputDecoration(
                                  label: Text(
                                      AppLocalizations.of(context)!.username),
                                ),
                                // onChanged: (v) => _bloc.add(InputEvent()),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        title: TextField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration(
                            label: Text(AppLocalizations.of(context)!.password),
                          ),
                          // onChanged: (v) => _bloc.add(InputEvent()),
                        ),
                      ),
                      state is AuthInProgress
                          ? const Center(
                              child: CircularProgressIndicator.adaptive(),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    _bloc.add(ToggleAuthEvent());
                                  },
                                  child: Text(_bloc.signupActive
                                      ? AppLocalizations.of(context)!
                                          .iHaveAnAccount
                                      : AppLocalizations.of(context)!.register),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary),
                                  onPressed:
                                      usernameController.text.isNotEmpty &&
                                              passwordController.text.isNotEmpty
                                          ? () {
                                              if (_bloc.signupActive) {
                                              } else {
                                                _bloc.add(
                                                  LoginEvent(
                                                      usernameController.text,
                                                      passwordController.text),
                                                );
                                              }
                                            }
                                          : null,
                                  child:
                                      Text(AppLocalizations.of(context)!.login),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
