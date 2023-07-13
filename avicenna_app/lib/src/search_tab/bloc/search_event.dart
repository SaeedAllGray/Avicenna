part of 'search_bloc.dart';

@immutable
abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class GetDoctors extends SearchEvent {
  final String searchTerm;

  const GetDoctors(this.searchTerm);
}
