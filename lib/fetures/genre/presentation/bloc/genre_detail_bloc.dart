import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mangap/fetures/genre/domain/entities/genre_detail_entity.dart';
import 'package:mangap/fetures/genre/domain/usecases/get_detail_genre_data.dart';
import 'package:mangap/fetures/genre/domain/usecases/get_detail_genre_page.dart';

part 'genre_detail_event.dart';
part 'genre_detail_state.dart';

class GenreDetailBloc extends Bloc<GenreDetailEvent, GenreDetailState> {
  GenreDetailBloc({
    required GetGenrePage getGenrePage,
    required GetDetailGenreData getDetailGenreData,
  })  : _getGenrePage = getGenrePage,
        _getDetailGenreData = getDetailGenreData,
        super(const GenreDetailState()) {
    on<GenreDetailGetPage>(_getGenreDetailPageHandler);
    on<GenreDetailGetDataGenre>(_getDetailGenreDataHandler);
    on<GenreDetailReset>(_resetGenreDetailState);
  }

  final GetGenrePage _getGenrePage;
  final GetDetailGenreData _getDetailGenreData;

  Future<void> _getGenreDetailPageHandler(
    GenreDetailGetPage event,
    Emitter<GenreDetailState> emit,
  ) async {
    emit(state.copyWith(status: GenreStatus.loading));

    final result = await _getGenrePage(event.href, event.page);

    result.fold(
      (failure) => emit(state.copyWith(
        status: GenreStatus.error,
        errorMessage: failure.errorMessage,
      )),
      (page) => emit(state.copyWith(
        status: GenreStatus.success,
        pageKomiks: page,
        hasReachedMax: page.current_page >= page.length_page,
      )),
    );
  }

  Future<void> _getDetailGenreDataHandler(
    GenreDetailGetDataGenre event,
    Emitter<GenreDetailState> emit,
  ) async {
    if (state.hasReachedMax) return;

    final result = await _getDetailGenreData(event.href, event.page);

    result.fold(
      (failure) => emit(state.copyWith(
        status: GenreStatus.error,
        errorMessage: failure.errorMessage,
      )),
      (newKomiks) {
        final existingIds =
            state.genreKomiks.map((komik) => komik.href).toSet();
        final filteredNewKomiks = newKomiks
            .where((komik) => !existingIds.contains(komik.href))
            .toList();

        final allKomiks = List.of(state.genreKomiks)..addAll(filteredNewKomiks);
        final hasNoMoreItems = newKomiks.isEmpty;

        emit(state.copyWith(
          status: GenreStatus.success,
          genreKomiks: allKomiks,
          hasReachedMax:
              hasNoMoreItems || event.page >= state.pageKomiks.length_page,
        ));
      },
    );
  }

  void _resetGenreDetailState(
    GenreDetailReset event,
    Emitter<GenreDetailState> emit,
  ) {
    emit(const GenreDetailState(
      genreKomiks: [],
      hasReachedMax: false,
      status: GenreStatus.loading,
    ));
  }
}
