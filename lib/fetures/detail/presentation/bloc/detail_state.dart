part of 'detail_bloc.dart';

enum DetailStatus { loading, success, error }

class DetailState extends Equatable {
  const DetailState({
    this.status = DetailStatus.loading,
    this.details = const KomikDetailEntity(
      href: '',
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
    this.bookmarks = const [],
    this.errorMessage = '',
    this.isBookmarked = false, // Tambahkan ini
  });

  final DetailStatus status;
  final KomikDetailEntity details;
  final List<GenreEntity> genres;
  final List<ChapterEntity> chapters;
  final List<KomikDetailEntity> bookmarks;
  final String errorMessage;
  final bool isBookmarked; // Tambahkan ini

  DetailState copyWith({
    DetailStatus? status,
    KomikDetailEntity? details,
    List<GenreEntity>? genres,
    List<ChapterEntity>? chapters,
    List<KomikDetailEntity>? bookmarks,
    String? errorMessage,
    bool? isBookmarked, // Tambahkan ini
  }) {
    return DetailState(
      status: status ?? this.status,
      details: details ?? this.details,
      genres: genres ?? this.genres,
      chapters: chapters ?? this.chapters,
      bookmarks: bookmarks ?? this.bookmarks,
      errorMessage: errorMessage ?? this.errorMessage,
      isBookmarked: isBookmarked ?? this.isBookmarked, // Tambahkan ini
    );
  }

  @override
  List<Object> get props => [
        status,
        details,
        genres,
        chapters,
        errorMessage,
        bookmarks,
        isBookmarked, // Tambahkan ini
      ];
}
