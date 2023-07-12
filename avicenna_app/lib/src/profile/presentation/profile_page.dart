import 'package:avicenna_app/src/auth/presentation/pages/login_page.dart';
import 'package:avicenna_app/src/models/doctor.dart';
import 'package:avicenna_app/src/models/patient.dart';
import 'package:avicenna_app/src/profile/data/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(GetUserInfoEvent()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is DeletionSucceed) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          }
        },
        builder: (context, state) {
          if (state is ProfileFetched) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Profile"),
              ),
              body: ListView(
                children: [
                  if (state.user is Doctor)
                    Visibility(
                      visible: state.user is Doctor,
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text('Name'),
                            trailing: Text(
                                '${(state.user as Doctor).firstname} ${(state.user as Doctor).lastname}'),
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
                            title: const Text('profession'),
                            trailing: Text((state.user as Doctor).profession),
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
                                '${(state.user as Patient).firstname} ${(state.user as Patient).lastname}'),
                          ),
                          ListTile(
                            title: const Text('Social Security No.'),
                            trailing: Text(
                                (state.user as Patient).socialSecurityNumber),
                          ),
                          ListTile(
                            title: const Text('Email'),
                            trailing: Text((state.user as Patient).email),
                          ),
                        ],
                      ),
                    ),
                  OutlinedButton(
                      onPressed: () => BlocProvider.of<ProfileBloc>(context)
                          .add(DeleteUser()),
                      child: const Text('Delete Account')),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
      ),
    );
  }
}
