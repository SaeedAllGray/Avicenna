part of 'doctors_bloc.dart';

sealed class DoctorsEvent extends Equatable {
  const DoctorsEvent();

  @override
  List<Object> get props => [];
}

class GetDoctors extends DoctorsEvent {
  const GetDoctors();
}

class SearchDoctors extends DoctorsEvent {
  final String searchTerm;

  const SearchDoctors({required this.searchTerm});
}
