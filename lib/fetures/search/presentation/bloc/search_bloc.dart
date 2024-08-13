import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mangap/fetures/search/domain/entities/search_entity.dart';
import 'package:mangap/fetures/search/domain/usecases/get_search.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetSearch _getSearch;
  SearchBloc({required GetSearch getSearch})
      : _getSearch = getSearch,
        super(const SearchState()) {
    on<SearchGetKomik>(_getSearchHandler);
  }

  Future<void> _getSearchHandler(
      SearchGetKomik event, Emitter<SearchState> emit) async {
    emit(state.copyWith(
        status: SearchStatus.loading, searchText: event.keyword));
    final result = await _getSearch.call(event.keyword);

    result.fold(
      (failure) {
        return emit(state.copyWith(
            status: SearchStatus.error, errorMessage: failure.errorMessage));
      },
      (komik) {
        return emit(
          state.copyWith(
            status: SearchStatus.success,
            searchKomik: komik,
          ),
        );
      },
    );
  }
}
