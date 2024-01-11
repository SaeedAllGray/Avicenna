import 'package:avicenna_app/domain/entries/doctor/doctor.dart';
import 'package:avicenna_app/domain/entries/user.dart';
import 'package:avicenna_app/domain/entries/user/user.dart';
import 'package:avicenna_app/presentation/features/doctor/pages/doctors_page.dart';
import 'package:avicenna_app/presentation/features/appointment/appointment_page.dart';
import 'package:avicenna_app/presentation/features/profile/profile.dart';
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
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: AppLocalizations.of(context)!.browse,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.schedule),
            label: AppLocalizations.of(context)!.schedules,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.bookmark),
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
        const ProfilePage()
      ];
  List<Widget> getPatientTabs() => <Widget>[
        DoctorsPage(),
        SchedulesPage(user: widget.user),
        AppointmentPage(
          user: widget.user,
        ),
        const ProfilePage()
      ];
}
