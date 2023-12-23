import 'package:avicenna_app/presentation/constants/colors.dart';
import 'package:avicenna_app/presentation/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  label: Text(AppLocalizations.of(context)!.username),
                ),
                // onChanged: (v) => _bloc.add(InputEvent()),
              ),
              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                    label: Text(AppLocalizations.of(context)!.password)),
                // onChanged: (v) => _bloc.add(InputEvent()),
              ),
              const SizedBox(
                height: 10,
              ),
              // state is AuthInProgress
              //     ? const Center(
              //         child: CircularProgressIndicator.adaptive(),
              //       ):
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary),
                  onPressed: usernameController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty
                      ? () {
                          // _bloc.add(LoginEvent(
                          //                   usernameController.text,
                          //                   passwordController.text))
                        }
                      : null,
                  child: Text(AppLocalizations.of(context)!.login)),
              TextButton(
                  onPressed: () {
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const SignupPage()));
                  },
                  child: Text(AppLocalizations.of(context)!.register)),
            ],
          ),
        ),
      ),
    );
  }
}
