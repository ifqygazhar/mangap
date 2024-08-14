import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mangap/fetures/read/domain/entities/read_entity.dart';
import 'package:mangap/fetures/read/domain/usecases/get_read_chapter.dart';

part 'read_event.dart';
part 'read_state.dart';

class ReadBloc extends Bloc<ReadEvent, ReadState> {
  final GetReadChapter _getReadChapter;
  ReadBloc({required GetReadChapter getReadChapter})
      : _getReadChapter = getReadChapter,
        super(const ReadState()) {
    on<ReadGetChapter>(_getReadChapterHandler);
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
}
