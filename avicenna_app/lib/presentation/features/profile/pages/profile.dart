import 'package:avicenna_app/application/user/user_bloc.dart';
import 'package:avicenna_app/domain/entries/doctor/doctor.dart';
import 'package:avicenna_app/domain/entries/patient/patient.dart';
import 'package:avicenna_app/presentation/constants/fonts.dart';
import 'package:avicenna_app/presentation/features/auth/auth_page.dart';
import 'package:avicenna_app/presentation/features/profile/widgets/alert_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final UserBloc _bloc = UserBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.profile),
      ),
      body: BlocProvider(
        create: (context) => _bloc..add(GetUserEvent()),
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserLoggedOutState) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const AuthPage()));
            }
          },
          builder: (context, state) {
            if (state is UserFetchedState) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (state.user is Patient)
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(AppLocalizations.of(context)!.name),
                        trailing: Text(
                          '${(state.user as Patient).user.firstName} ${(state.user as Patient).user.lastName}',
                          style: FontStyles.BLACK_REGULAR_16,
                        ),
                      ),
                    if (state.user is Doctor)
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(AppLocalizations.of(context)!.name),
                        trailing: Text(
                          '${(state.user as Doctor).user.firstName} ${(state.user as Doctor).user.lastName}',
                          style: FontStyles.BLACK_REGULAR_16,
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state.user is Patient)
                      ListTile(
                        leading: const Icon(Icons.numbers),
                        title: Text(AppLocalizations.of(context)!.socialNumber),
                        trailing: Text(
                          (state.user as Patient).ssn,
                          style: FontStyles.BLACK_REGULAR_16,
                        ),
                      ),
                    if (state.user is Doctor)
                      ListTile(
                        leading: const Icon(Icons.phone),
                        title: Text(AppLocalizations.of(context)!.phone),
                        trailing: Text(
                          (state.user as Doctor).phoneNumber,
                          style: FontStyles.BLACK_REGULAR_16,
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state.user is Patient)
                      ListTile(
                        leading: const Icon(Icons.remember_me),
                        title: Text(AppLocalizations.of(context)!.username),
                        trailing: Text(
                          (state.user as Patient).user.username,
                          style: FontStyles.BLACK_REGULAR_16,
                        ),
                      ),
                    if (state.user is Doctor)
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: Text(AppLocalizations.of(context)!.email),
                        trailing: Text(
                          (state.user as Doctor).user.email,
                          style: FontStyles.BLACK_REGULAR_16,
                        ),
                      ),
                    const SizedBox(height: 10),
                    if (state.user is Doctor)
                      ListTile(
                        leading: const Icon(Icons.healing),
                        title: Text(AppLocalizations.of(context)!.profession),
                        trailing: Text(
                          (state.user as Doctor).specialization,
                          style: FontStyles.BLACK_REGULAR_16,
                        ),
                      ),
                    if (state.user is Patient)
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: Text(AppLocalizations.of(context)!.email),
                        trailing: Text(
                          (state.user as Patient).user.email,
                          style: FontStyles.BLACK_REGULAR_16,
                        ),
                      ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: ButtonStyle(
                          // Customize the outline color
                          side: MaterialStateProperty.all<BorderSide>(
                            const BorderSide(
                              color:
                                  Colors.teal, // Set your desired outline color
                              width: 2.0, // Set the outline thickness
                            ),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.logout,
                        ),
                        onPressed: () => _showDialog(context, LogoutEvent()),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: ButtonStyle(
                          // Customize the outline color
                          side: MaterialStateProperty.all<BorderSide>(
                            const BorderSide(
                              color:
                                  Colors.red, // Set your desired outline color
                              width: 2.0, // Set the outline thickness
                            ),
                          ),

                          textStyle: MaterialStateProperty.all<TextStyle>(
                            const TextStyle(
                              fontSize: 16.0, // Set the font size
                              fontWeight:
                                  FontWeight.bold, // Set the font weight
                              color: Colors.red,
                            ),
                          ),
                        ),
                        onPressed: () =>
                            _showDialog(context, DeleteUserEvent()),
                        child: Text(
                          AppLocalizations.of(context)!.delete,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
        ),
      ),
    );
  }

  Future<void> _showDialog(BuildContext context, UserEvent event) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AppAlertDialog(onConfirmPressed: () => _bloc.add(event));
      },
    );
  }
}
