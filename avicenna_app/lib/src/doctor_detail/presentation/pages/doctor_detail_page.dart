import 'package:avicenna_app/src/constants/fonts.dart';
import 'package:avicenna_app/src/doctor_detail/presentation/bloc/doctor_detail_bloc.dart';
import 'package:avicenna_app/src/models/doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';

class DoctorDetailsPage extends StatelessWidget {
  final Doctor doctor;
  final DoctorDetailBloc _bloc = DoctorDetailBloc();

  DoctorDetailsPage({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc..add(GetAllAppointments(doctor.id)),
      child: BlocListener<DoctorDetailBloc, DoctorDetailState>(
        listener: (context, state) {
          if (state is AppointmentCreated) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("You have successfully made an appointment."),
            ));
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Doctor Details'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.person),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  '${doctor.firstname} ${doctor.lastname}',
                  style: FontStyles.BLACK_MEDIUM_24,
                ),
                Text(
                  doctor.profession,
                  style: FontStyles.BLACK_REGULAR_18,
                ),
                ListTile(
                  leading: const Icon(Icons.work),
                  title: Text(
                    doctor.address,
                    style: FontStyles.BLACK_REGULAR_18,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: Text(
                    doctor.email,
                    style: FontStyles.BLACK_REGULAR_18,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: Text(
                    doctor.phoneNumber,
                    style: FontStyles.BLACK_REGULAR_18,
                  ),
                ),
                const SizedBox(height: 16.0),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Schedules:',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(height: 8.0),
                BlocBuilder<DoctorDetailBloc, DoctorDetailState>(
                  builder: (context, state) {
                    if (state is DoctorDetailInFetched) {
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.appointments.length,
                          itemBuilder: (context, index) {
                            DateTime schedule =
                                state.appointments[index].datetime;
                            return ListTile(
                              title: Text(
                                DateFormat('EEEE, MMMM d, HH:mm')
                                    .format(schedule),
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              trailing: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder()),
                                child: const Icon(Icons.add),
                                onPressed: () {
                                  _bloc.add(MakeAppointment(doctor.id,
                                      state.appointments[index].datetime));
                                },
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
