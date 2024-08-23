import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mangap/fetures/read/domain/entities/read_entity.dart';
import 'package:mangap/fetures/read/domain/usecases/delete_chapter.dart';
import 'package:mangap/fetures/read/domain/usecases/get_read_chapter.dart';
import 'package:mangap/fetures/read/domain/usecases/get_save_chapter.dart';
import 'package:mangap/fetures/read/domain/usecases/save_chapter.dart';

part 'read_event.dart';
part 'read_state.dart';

class ReadBloc extends Bloc<ReadEvent, ReadState> {
  final GetReadChapter _getReadChapter;
  final SaveChapter _saveChapter;
  final GetSaveChapter _getSaveChapter;
  final DeleteChapter _deleteChapter;
  ReadBloc({
    required GetReadChapter getReadChapter,
    required SaveChapter saveChapter,
    required GetSaveChapter getSaveChapter,
    required DeleteChapter deleteChapter,
  })  : _getReadChapter = getReadChapter,
        _saveChapter = saveChapter,
        _getSaveChapter = getSaveChapter,
        _deleteChapter = deleteChapter,
        super(const ReadState()) {
    on<ReadGetChapter>(_getReadChapterHandler);
    on<ReadSaveChapter>(_saveChapterHandler);
    on<ReadRemoveChapter>(_deleteChapterHandler);
    on<ReadGetSaveChapter>(_getSaveChapterHandler);
    on<ReadLoadingEvent>((event, emit) {
      emit(state.copyWith(status: ReadStatus.loading));
    });
  }

  Future<void> _getReadChapterHandler(
      ReadGetChapter event, Emitter<ReadState> emit) async {
    emit(state.copyWith(status: ReadStatus.loading));
    final result = await _getReadChapter.call(event.href);

    result.fold(
      (failure) {
        return emit(
          state.copyWith(
            status: ReadStatus.error,
            errorMessage: failure.errorMessage,
          ),
        );
      },
      (komik) {
        return emit(
          state.copyWith(status: ReadStatus.success, read: komik),
        );
      },
    );
  }

  Future<void> _saveChapterHandler(
      ReadSaveChapter event, Emitter<ReadState> emit) async {
    final existingChapter = state.saveRead
        .where((ch) => ch.title == event.chapter.title)
        .isNotEmpty;

    if (existingChapter) {
      return;
    }

    final result = await _saveChapter.call(event.chapter);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ReadStatus.error,
          errorMessage: failure.errorMessage,
        ),
      ),
      (_) {
        final updateChapter = List<ReadEntity>.from(state.saveRead)
          ..add(event.chapter);
        emit(state.copyWith(
          status: ReadStatus.success,
          saveRead: updateChapter,
        ));
      },
    );
  }

  Future<void> _deleteChapterHandler(
      ReadRemoveChapter event, Emitter<ReadState> emit) async {
    final result = await _deleteChapter.call(event.chapter);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ReadStatus.error,
          errorMessage: failure.errorMessage,
        ),
      ),
      (_) {
        final updateChapter = List<ReadEntity>.from(state.saveRead)
          ..remove(event.chapter);
        emit(
          state.copyWith(
            status: ReadStatus.success,
            saveRead: updateChapter,
          ),
        );
      },
    );
  }

  Future<void> _getSaveChapterHandler(
      ReadGetSaveChapter event, Emitter<ReadState> emit) async {
    final result = await _getSaveChapter.call();
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ReadStatus.error,
          errorMessage: failure.errorMessage,
        ),
      ),
      (read) {
        emit(
          state.copyWith(
            status: ReadStatus.success,
            saveRead: read,
          ),
        );
      },
    );
  }
}
