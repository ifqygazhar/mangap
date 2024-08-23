import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mangap/fetures/detail/domain/entities/komik_detail_entity.dart';
import 'package:mangap/fetures/detail/domain/usecases/deleted_detail_saved_komik.dart';
import 'package:mangap/fetures/detail/domain/usecases/get_detail_chapter_komik.dart';
import 'package:mangap/fetures/detail/domain/usecases/get_detail_genre_komik.dart';
import 'package:mangap/fetures/detail/domain/usecases/get_detail_komik.dart';
import 'package:mangap/fetures/detail/domain/usecases/get_detail_saved_komik.dart';
import 'package:mangap/fetures/detail/domain/usecases/save_detail_komik.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc({
    required GetDetail getDetail,
    required GetGenre getGenre,
    required GetChapter getChapter,
    required SaveDetailKomik saveDetailKomik,
    required DeletedDetailSavedKomik deletedDetailSavedKomik,
    required GetDetailSavedKomik getDetailSavedKomik,
  })  : _getDetail = getDetail,
        _getGenre = getGenre,
        _getChapter = getChapter,
        _saveDetailKomik = saveDetailKomik,
        _deletedDetailSavedKomik = deletedDetailSavedKomik,
        _getDetailSavedKomik = getDetailSavedKomik,
        super(const DetailState()) {
    on<DetailGetInformationManga>(_getDetailHandler);
    on<DetailGetInformationGenre>(_getGenreHandler);
    on<DetailGetInformationChapter>(_getChapterHandler);
    on<DetailRefresh>(_refreshHandler);
    on<DetailReset>((event, emit) {
      emit(const DetailState());
    });
    on<DetailAddBookmark>(_addBookmarkHandler);
    on<DetailRemoveBookmark>(_removeBookmarkHandler);
    on<DetailGetBookmarks>(_getBookmarksHandler);
  }

  final GetDetail _getDetail;
  final GetGenre _getGenre;
  final GetChapter _getChapter;
  final SaveDetailKomik _saveDetailKomik;
  final DeletedDetailSavedKomik _deletedDetailSavedKomik;
  final GetDetailSavedKomik _getDetailSavedKomik;

  Future<void> _getDetailHandler(
      DetailGetInformationManga event, Emitter<DetailState> emit) async {
    final result = await _getDetail.call(event.href);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
              status: DetailStatus.error, errorMessage: failure.errorMessage),
        );
      },
      (details) async {
        final bookmarkResult = await _getDetailSavedKomik.call('');
        bookmarkResult.fold(
          (failure) {
            emit(
              state.copyWith(
                  status: DetailStatus.error,
                  errorMessage: failure.errorMessage),
            );
          },
          (bookmarks) {
            final isBookmarked =
                bookmarks.any((komik) => komik.href == details.href);
            emit(state.copyWith(
              status: DetailStatus.success,
              details: details,
              isBookmarked: isBookmarked,
            ));
          },
        );
      },
    );
  }

  Future<void> _getGenreHandler(
      DetailGetInformationGenre event, Emitter<DetailState> emit) async {
    final result = await _getGenre.call(event.href);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
              status: DetailStatus.error, errorMessage: failure.errorMessage),
        );
      },
      (genres) {
        emit(
          state.copyWith(status: DetailStatus.success, genres: genres),
        );
      },
    );
  }

  Future<void> _getChapterHandler(
      DetailGetInformationChapter event, Emitter<DetailState> emit) async {
    final result = await _getChapter.call(event.href);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
              status: DetailStatus.error, errorMessage: failure.errorMessage),
        );
      },
      (chapters) {
        emit(
          state.copyWith(status: DetailStatus.success, chapters: chapters),
        );
      },
    );
  }

  Future<void> _refreshHandler(
    DetailRefresh event,
    Emitter<DetailState> emit,
  ) async {
    emit(const DetailState());

    emit(state.copyWith(status: DetailStatus.loading));

    try {
      // Fetch the manga details again
      final detailResult = await _getDetail.call(event.href);
      await detailResult.fold(
        (failure) async {
          emit(
            state.copyWith(
              status: DetailStatus.error,
              errorMessage: failure.errorMessage,
            ),
          );
        },
        (details) async {
          // Fetch the bookmarks again after updating the details
          final bookmarkResult = await _getDetailSavedKomik.call(event.href);
          await bookmarkResult.fold(
            (failure) async {
              emit(
                state.copyWith(
                  status: DetailStatus.error,
                  errorMessage: failure.errorMessage,
                ),
              );
            },
            (bookmarks) async {
              final isBookmarked = bookmarks
                  .where((komik) => komik.href == event.href)
                  .isNotEmpty;

              final genreResult = await _getGenre.call(event.href);
              await genreResult.fold(
                (failure) async {
                  emit(
                    state.copyWith(
                      status: DetailStatus.error,
                      errorMessage: failure.errorMessage,
                    ),
                  );
                },
                (genres) async {
                  // Fetch chapters associated with the details
                  final chapterResult = await _getChapter.call(event.href);
                  await chapterResult.fold(
                    (failure) async {
                      emit(
                        state.copyWith(
                          status: DetailStatus.error,
                          errorMessage: failure.errorMessage,
                        ),
                      );
                    },
                    (chapters) async {
                      // Emit final state with all refreshed data

                      emit(state.copyWith(
                        status: DetailStatus.success,
                        details: details,
                        genres: genres,
                        chapters: chapters,
                        bookmarks: bookmarks,
                        isBookmarked: isBookmarked,
                      ));
                    },
                  );
                },
              );
            },
          );
        },
      );
    } catch (e) {
      emit(state.copyWith(
        status: DetailStatus.error,
        errorMessage: 'Unexpected error occurred: $e',
      ));
    }
  }

  Future<void> _addBookmarkHandler(
      DetailAddBookmark event, Emitter<DetailState> emit) async {
    final result = await _saveDetailKomik.call(event.detail);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: DetailStatus.error,
          errorMessage: failure.errorMessage,
        ),
      ),
      (_) {
        // Pastikan bookmark ditambahkan ke daftar bookmark
        final updatedBookmarks = List<KomikDetailEntity>.from(state.bookmarks)
          ..add(event.detail);

        emit(state.copyWith(
          status: DetailStatus.success,
          isBookmarked: true,
          bookmarks: updatedBookmarks,
        ));
      },
    );
  }

  Future<void> _removeBookmarkHandler(
      DetailRemoveBookmark event, Emitter<DetailState> emit) async {
    final result = await _deletedDetailSavedKomik.call(event.detail);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: DetailStatus.error,
          errorMessage: failure.errorMessage,
        ),
      ),
      (_) {
        // Pastikan bookmark dihapus dari daftar bookmark
        final updatedBookmarks = List<KomikDetailEntity>.from(state.bookmarks)
          ..remove(event.detail);
        emit(state.copyWith(
          status: DetailStatus.success,
          isBookmarked: false,
          bookmarks: updatedBookmarks,
        ));
      },
    );
  }

  Future<void> _getBookmarksHandler(
      DetailGetBookmarks event, Emitter<DetailState> emit) async {
    final result = await _getDetailSavedKomik.call('');
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: DetailStatus.error,
          errorMessage: failure.errorMessage,
        ),
      ),
      (bookmarks) {
        emit(state.copyWith(
          status: DetailStatus.success,
          bookmarks: bookmarks,
          isBookmarked: true,
        ));
      },
    );
  }
}
