part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchGetKomik extends SearchEvent {
  final String keyword;
  const SearchGetKomik(this.keyword);

  @override
  List<Object> get props => [keyword];
}
