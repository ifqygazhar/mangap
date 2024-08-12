import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mangap/fetures/manga/domain/entities/manga_entity.dart';
import 'package:mangap/fetures/manga/domain/usecases/get_all_manga.dart';

part 'manga_event.dart';
part 'manga_state.dart';

class MangaBloc extends Bloc<MangaEvent, MangaState> {
  MangaBloc({required GetAllManga getAllManga})
      : _getAllManga = getAllManga,
        super(const MangaState()) {
    on<Manga>(_getAllMangaHandler);
    on<MangaReset>(_mangaResetHandler);
  }

  final GetAllManga _getAllManga;

  Future<void> _getAllMangaHandler(
      Manga event, Emitter<MangaState> emit) async {
    if (state.hasReachedMax) return;

    final result = await _getAllManga.call(event.page);

    result.fold(
      (failure) {
        return emit(
          state.copyWith(
            status: MangaStatus.error,
            errorMessage: failure.errorMessage,
          ),
        );
      },
      (komik) {
        return emit(
          state.copyWith(
            status: MangaStatus.success,
            manga: List.of(state.manga)..addAll(komik),
            hasReachedMax: komik.isEmpty,
          ),
        );
      },
    );
  }
}

void _mangaResetHandler(MangaReset event, Emitter<MangaState> emit) {
  emit(
    const MangaState(
      manga: [],
      hasReachedMax: false,
      status: MangaStatus.loading,
    ),
  );
}
