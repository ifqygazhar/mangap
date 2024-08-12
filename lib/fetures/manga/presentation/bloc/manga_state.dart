part of 'manga_bloc.dart';

enum MangaStatus { loading, error, success }

class MangaState extends Equatable {
  const MangaState({
    this.page = 1,
    this.status = MangaStatus.loading,
    this.manga = const [],
    this.errorMessage = '',
    this.hasReachedMax = false,
  });

  final List<MangaEntity> manga;
  final String errorMessage;
  final bool hasReachedMax;
  final MangaStatus status;
  final int page;

  MangaState copyWith({
    List<MangaEntity>? manga,
    String? errorMessage,
    bool? hasReachedMax,
    MangaStatus? status,
    int? page,
  }) {
    return MangaState(
      manga: manga ?? this.manga,
      errorMessage: errorMessage ?? this.errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      page: page ?? this.page,
    );
  }

  @override
  List<Object> get props => [manga, errorMessage, hasReachedMax, status, page];
}
