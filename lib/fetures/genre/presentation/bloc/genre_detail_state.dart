part of 'genre_detail_bloc.dart';

enum GenreStatus { loading, success, error }

class GenreDetailState extends Equatable {
  const GenreDetailState({
    this.hasReachedMax = false,
    this.status = GenreStatus.loading,
    this.pageKomiks =
        const KomikGenreDetailEntity(current_page: 1, length_page: 1),
    this.genreKomiks = const [],
    this.errorMessage = '',
  });

  final GenreStatus status;

  final KomikGenreDetailEntity pageKomiks;
  final List<KomikGenreDetailDataEntity> genreKomiks;
  final bool hasReachedMax;

  final String errorMessage;

  GenreDetailState copyWith({
    GenreStatus? status,
    KomikGenreDetailEntity? pageKomiks,
    List<KomikGenreDetailDataEntity>? genreKomiks,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return GenreDetailState(
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      pageKomiks: pageKomiks ?? this.pageKomiks,
      genreKomiks: genreKomiks ?? this.genreKomiks,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        pageKomiks,
        hasReachedMax,
        genreKomiks,
        errorMessage,
      ];
}
