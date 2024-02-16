import 'package:avicenna_app/domain/entries/doctor/doctor.dart';
import 'package:avicenna_app/domain/entries/user.dart';
import 'package:avicenna_app/presentation/helpers/on_boarding_helper.dart';

import 'package:avicenna_app/presentation/features/doctor/pages/doctors_page.dart';
import 'package:avicenna_app/presentation/features/appointment/appointment_page.dart';
import 'package:avicenna_app/presentation/features/profile/pages/profile.dart';
import 'package:avicenna_app/presentation/features/time_stamp/pages/schedules_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  final AbstractUser user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widget.user is Doctor
            ? getDoctorTabs().elementAt(_selectedIndex)
            : getPatientTabs().elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          if (widget.user is! Doctor)
            BottomNavigationBarItem(
              icon: Icon(key: OnBoardingHelper.patientKeys[0], Icons.search),
              label: AppLocalizations.of(context)!.browse,
            ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.schedule,
              key: widget.user is Doctor
                  ? OnBoardingHelper.doctorKeys[0]
                  : OnBoardingHelper.patientKeys[1],
            ),
            label: AppLocalizations.of(context)!.schedules,
          ),
          if (widget.user is Doctor)
            BottomNavigationBarItem(
              icon: Icon(
                Icons.bookmark,
                key: OnBoardingHelper.doctorKeys[2],
              ),
              label: AppLocalizations.of(context)!.appointment,
            ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: AppLocalizations.of(context)!.account,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  List<Widget> getDoctorTabs() => <Widget>[
        SchedulesPage(user: widget.user),
        AppointmentPage(
          user: widget.user,
        ),
        ProfilePage()
      ];
  List<Widget> getPatientTabs() => <Widget>[
        DoctorsPage(),
        SchedulesPage(user: widget.user),
        ProfilePage(),
      ];
}
