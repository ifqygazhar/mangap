part of 'search_bloc.dart';

enum SearchStatus { loading, error, success }

class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.loading,
    this.searchKomik = const [],
    this.errorMessage = '',
    this.searchText = '',
  });

  final SearchStatus status;
  final List<SearchEntity> searchKomik;
  final String errorMessage;
  final String searchText;

  SearchState copyWith({
    SearchStatus? status,
    List<SearchEntity>? searchKomik,
    String? errorMessage,
    String? searchText,
  }) {
    return SearchState(
        searchKomik: searchKomik ?? this.searchKomik,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        searchText: searchText ?? this.searchText);
  }

  @override
  List<Object> get props => [status, searchKomik, errorMessage, searchText];
}
