import 'package:avicenna_app/application/user/user_bloc.dart';
import 'package:avicenna_app/domain/entries/doctor/doctor.dart';
import 'package:avicenna_app/domain/entries/patient/patient.dart';
import 'package:avicenna_app/presentation/features/auth/auth_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: BlocProvider(
        create: (context) => UserBloc()..add(GetUserEvent()),
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is LogoutEvent) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const AuthPage()));
            }
          },
          builder: (context, state) {
            if (state is UserFetchedState) {
              return ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  if (state.user is Doctor)
                    Visibility(
                      visible: state.user is Doctor,
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text('Name'),
                            trailing: Text(
                                '${(state.user as Doctor).firstName} ${(state.user as Doctor).lastName}'),
                          ),
                          ListTile(
                            title: const Text('Phone Number'),
                            trailing: Text((state.user as Doctor).phoneNumber),
                          ),
                          ListTile(
                            title: const Text('Email'),
                            trailing: Text((state.user as Doctor).email),
                          ),
                          ListTile(
                            title: const Text('Profession'),
                            trailing:
                                Text((state.user as Doctor).specialization),
                          ),
                        ],
                      ),
                    ),
                  if (state.user is Patient)
                    Visibility(
                      visible: state.user is Patient,
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text('Name'),
                            trailing: Text(
                                '${(state.user as Patient).firstName} ${(state.user as Patient).lastName}'),
                          ),
                          ListTile(
                            title: const Text('Social Security No.'),
                            trailing: Text((state.user as Patient).ssn),
                          ),
                          ListTile(
                            title: const Text('Email'),
                            trailing: Text((state.user as Patient).email),
                          ),
                        ],
                      ),
                    ),
                  OutlinedButton(
                    style: ButtonStyle(
                      // Customize the outline color
                      side: MaterialStateProperty.all<BorderSide>(
                        const BorderSide(
                          color: Colors.teal, // Set your desired outline color
                          width: 2.0, // Set the outline thickness
                        ),
                      ),
                    ),
                    child: const Text(
                      'Logout',
                    ),
                    onPressed: () =>
                        BlocProvider.of<UserBloc>(context).add(LogoutEvent()),
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                      // Customize the outline color
                      side: MaterialStateProperty.all<BorderSide>(
                        const BorderSide(
                          color: Colors.red, // Set your desired outline color
                          width: 2.0, // Set the outline thickness
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                      ),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        const TextStyle(
                          fontSize: 16.0, // Set the font size
                          fontWeight: FontWeight.bold, // Set the font weight
                          color: Colors.red,
                        ),
                      ),
                    ),
                    onPressed: () => BlocProvider.of<UserBloc>(context)
                        .add(DeleteUserEvent()),
                    child: const Text(
                      'Delete Account',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
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
}
