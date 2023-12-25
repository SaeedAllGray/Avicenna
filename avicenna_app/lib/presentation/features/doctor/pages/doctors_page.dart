
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class DoctorsPage extends StatelessWidget {
//   final TextEditingController searchController = TextEditingController();
//   DoctorsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => SearchBloc()..add(const GetDoctors("")),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Search"),
//         ),
//         body: BlocBuilder<SearchBloc, SearchState>(
//           builder: (context, state) {
//             if (state is SearchInProgress) {
//               return const Center(child: CircularProgressIndicator.adaptive());
//             } else if (state is SearchSucceed) {
//               return Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       controller: searchController,
//                       decoration: InputDecoration(
//                         suffixIcon: IconButton(
//                           onPressed: () {
//                             BlocProvider.of<SearchBloc>(context)
//                                 .add(GetDoctors(''));
//                             searchController.clear();
//                           },
//                           icon: const Icon(Icons.clear),
//                         ),
//                         label: const Text('Search'),
//                       ),
//                       onChanged: (v) => BlocProvider.of<SearchBloc>(context)
//                           .add(GetDoctors(searchController.text)),
//                     ),
//                   ),
//                   Expanded(
//                     child: ListView.builder(
//                         itemCount: state.doctors.length,
//                         itemBuilder: (context, index) => ListTile(
//                               onTap: () {
//                                 Navigator.of(context).push(
//                                   MaterialPageRoute(
//                                     builder: (context) => DoctorDetailsPage(
//                                       doctor: state.doctors[index],
//                                     ),
//                                   ),
//                                 );
//                               },
//                               trailing: const Icon(Icons.chevron_right),
//                               title: Text(
//                                   "${state.doctors[index].firstname} ${state.doctors[index].lastname}"),
//                               subtitle: Text(state.doctors[index].profession),
//                             )),
//                   ),
//                 ],
//               );
//             }
//             return Container();
//           },
//         ),
//       ),
//     );
//   }
// }
