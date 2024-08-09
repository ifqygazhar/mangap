import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mangap/core/errors/failures.dart';
import 'package:mangap/fetures/detail/domain/entities/komik_detail_entity.dart';
import 'package:mangap/fetures/detail/domain/usecases/get_detail_chapter_komik.dart';
import 'package:mangap/fetures/detail/domain/usecases/get_detail_genre_komik.dart';
import 'package:mangap/fetures/detail/domain/usecases/get_detail_komik.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc({
    required GetDetail getDetail,
    required GetGenre getGenre,
    required GetChapter getChapter,
  })  : _getDetail = getDetail,
        _getGenre = getGenre,
        _getChapter = getChapter,
        super(const DetailState()) {
    on<DetailGetInformationManga>(_getDetailHandler);
    on<DetailGetInformationGenre>(_getGenreHandler);
    on<DetailGetInformationChapter>(_getChapterHandler);
    on<DetailRefresh>(_refreshHandler);
    on<DetailReset>((event, emit) {
      emit(const DetailState());
    });
  }
  final GetDetail _getDetail;
  final GetGenre _getGenre;
  final GetChapter _getChapter;

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
      (details) {
        emit(
          state.copyWith(status: DetailStatus.success, details: details),
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
    emit(state.copyWith(status: DetailStatus.loading)); // Set state to loading

    try {
      // Start all data fetching concurrently
      final detailFuture = _getDetail.call(event.href);
      final genreFuture = _getGenre.call(event.href);
      final chapterFuture = _getChapter.call(event.href);

      // Wait for all results to complete and type cast them properly
      final results =
          await Future.wait([detailFuture, genreFuture, chapterFuture]);

      final detailOutcome = results[0] as Either<Failure, KomikDetailEntity>;
      final genreOutcome = results[1] as Either<Failure, List<GenreEntity>>;
      final chapterOutcome = results[2] as Either<Failure, List<ChapterEntity>>;

      // Handle detail result
      detailOutcome.fold(
        (failure) {
          throw failure;
        },
        (details) {
          emit(state.copyWith(details: details));
        },
      );

      // Handle genre result
      genreOutcome.fold(
        (failure) {
          throw failure;
        },
        (genres) {
          emit(state.copyWith(genres: genres));
        },
      );

      // Handle chapter result
      chapterOutcome.fold(
        (failure) {
          throw failure;
        },
        (chapters) {
          emit(state.copyWith(chapters: chapters));
        },
      );

      // If all succeeded, set status to success
      emit(state.copyWith(status: DetailStatus.success));
    } catch (error) {
      // If any request fails, set status to error
      emit(state.copyWith(
        status: DetailStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }
}
