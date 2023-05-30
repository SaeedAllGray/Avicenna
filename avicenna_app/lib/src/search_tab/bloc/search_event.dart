part of 'search_bloc.dart';

@immutable
abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchRequestedEvent extends SearchEvent {
  final String searchTerm;

  const SearchRequestedEvent(this.searchTerm);
}
