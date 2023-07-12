import 'package:avicenna_app/src/doctor_detail/presentation/pages/doctor_detail_page.dart';
import 'package:avicenna_app/src/search_tab/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc()..add(const SearchRequestedEvent("")),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Search"),
        ),
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchInProgress) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (state is SearchSucceed) {
              return ListView.builder(
                  itemCount: state.doctors.length,
                  itemBuilder: (context, index) => ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DoctorDetailsPage(
                                doctor: state.doctors[index],
                              ),
                            ),
                          );
                        },
                        trailing: const Icon(Icons.chevron_right),
                        title: Text(
                            "${state.doctors[index].firstname} ${state.doctors[index].lastname}"),
                        subtitle: Text(state.doctors[index].profession),
                      ));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
