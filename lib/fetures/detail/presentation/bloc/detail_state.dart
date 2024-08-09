part of 'detail_bloc.dart';

enum DetailStatus { loading, success, error }

class DetailState extends Equatable {
  const DetailState({
    this.status = DetailStatus.loading,
    this.details = const KomikDetailEntity(
      title: '',
      altTitle: '',
      updatedOn: '',
      rating: '7.89',
      status: '',
      type: '',
      released: '',
      author: '',
      description: '',
      thumbnail: '',
    ),
    this.genres = const [],
    this.chapters = const [],
    this.errorMessage = '',
  });

  final DetailStatus status;

  final KomikDetailEntity details;
  final List<GenreEntity> genres;
  final List<ChapterEntity> chapters;

  final String errorMessage;

  DetailState copyWith({
    DetailStatus? status,
    KomikDetailEntity? details,
    List<GenreEntity>? genres,
    List<ChapterEntity>? chapters,
    String? errorMessage,
  }) {
    return DetailState(
      status: status ?? this.status,
      details: details ?? this.details,
      genres: genres ?? this.genres,
      chapters: chapters ?? this.chapters,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        details,
        genres,
        chapters,
        errorMessage,
      ];
}
