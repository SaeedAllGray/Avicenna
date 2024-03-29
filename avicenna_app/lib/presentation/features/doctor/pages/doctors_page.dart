import 'package:avicenna_app/application/doctors/doctors_bloc.dart';
import 'package:avicenna_app/presentation/constants/api_constant.dart';
import 'package:avicenna_app/presentation/constants/colors.dart';
import 'package:avicenna_app/presentation/features/doctor/pages/doctor_detail_page.dart';
import 'package:avicenna_app/presentation/helpers/on_boarding_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DoctorsPage extends StatefulWidget {
  const DoctorsPage({super.key});

  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (ApiConstants.isTheFirstTimeAppLaunch) {
      Future.delayed(
        const Duration(milliseconds: 500),
        () => OnBoardingHelper.patientTutorial.show(context: context),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorsBloc()..add(const GetDoctors()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(AppLocalizations.of(context)!.browse),
          bottom: PreferredSize(
            preferredSize: const Size(50, 50),
            child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: BlocBuilder<DoctorsBloc, DoctorsState>(
                builder: (context, state) {
                  return TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.search,
                        fillColor: AppColors.primary.withOpacity(0.15),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppColors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppColors.white,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            BlocProvider.of<DoctorsBloc>(context)
                                .add(const SearchDoctors(searchTerm: ''));
                            searchController.clear();
                          },
                          icon: const Icon(Icons.clear),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10)),
                    onChanged: (v) => BlocProvider.of<DoctorsBloc>(context)
                        .add(SearchDoctors(searchTerm: searchController.text)),
                  );
                },
              ),
            ),
          ),
        ),
        body: BlocBuilder<DoctorsBloc, DoctorsState>(
          builder: (context, state) {
            if (state is DoctorsInProgress) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (state is DoctorsSucceed) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: state.doctors.length,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DoctorDetailsPage(
                                  doctor: state.doctors[index],
                                ),
                              ),
                            );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          tileColor: AppColors.white,
                          trailing: const Icon(Icons.chevron_right),
                          title: Text(
                              "${state.doctors[index].user.firstName} ${state.doctors[index].user.lastName}"),
                          subtitle: Text(state.doctors[index].specialization),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
