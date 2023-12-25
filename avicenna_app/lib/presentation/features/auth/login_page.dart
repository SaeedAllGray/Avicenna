import 'package:avicenna_app/application/auth/auth_bloc.dart';
import 'package:avicenna_app/presentation/constants/colors.dart';
import 'package:avicenna_app/presentation/constants/fonts.dart';
import 'package:avicenna_app/presentation/features/home.dart';
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    addressController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    ssnController.dispose();
    emailController.dispose();
    professionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is! AuthSucceedState) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          bloc: _bloc,
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal,
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/avicenna.png',
                      color: Colors.white,
                      height: 20,
                    ),
                    Text(
                      AppLocalizations.of(context)!.appTitle,
                      style: FontStyles.WHITE_MEDIUM_24,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Visibility(
                        maintainAnimation: true,
                        maintainState: true,
                        visible: _bloc.signupActive,
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 500),
                          opacity: _bloc.signupActive ? 1 : 0.0,
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
                                  onChanged: (v) => _bloc.add(InputEvent()),
                                  decoration: InputDecoration(
                                      label: Text(AppLocalizations.of(context)!
                                          .firstName)),
                                ),
                              ),
                              ListTile(
                                title: TextField(
                                  controller: lastNameController,
                                  onChanged: (v) => _bloc.add(InputEvent()),
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
                                    onChanged: (v) => _bloc.add(InputEvent()),
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
                                    onChanged: (v) => _bloc.add(InputEvent()),
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
                                    onChanged: (v) => _bloc.add(InputEvent()),
                                    decoration: InputDecoration(
                                        label: Text(
                                            AppLocalizations.of(context)!
                                                .phone)),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: isChecked,
                                child: ListTile(
                                  title: TextField(
                                    controller: addressController,
                                    onChanged: (v) => _bloc.add(InputEvent()),
                                    decoration: InputDecoration(
                                      label: Text(AppLocalizations.of(context)!
                                          .address),
                                    ),
                                  ),
                                ),
                              ),
                              ListTile(
                                title: TextField(
                                  obscureText: true,
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    label: Text(
                                        AppLocalizations.of(context)!.email),
                                  ),
                                  onChanged: (v) => _bloc.add(InputEvent()),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListTile(
                        title: TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            label: Text(AppLocalizations.of(context)!.username),
                          ),
                          onChanged: (v) => _bloc.add(InputEvent()),
                        ),
                      ),
                      ListTile(
                        title: TextField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration(
                            label: Text(AppLocalizations.of(context)!.password),
                          ),
                          onChanged: (v) => _bloc.add(InputEvent()),
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
