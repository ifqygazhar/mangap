part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object?> get props => [];
}

class DetailGetInformationManga extends DetailEvent {
  final String href;

  const DetailGetInformationManga(this.href);

  @override
  List<Object?> get props => [href];
}

class DetailGetInformationGenre extends DetailEvent {
  final String href;

  const DetailGetInformationGenre(this.href);

  @override
  List<Object?> get props => [href];
}

class DetailGetInformationChapter extends DetailEvent {
  final String href;

  const DetailGetInformationChapter(this.href);

  @override
  List<Object?> get props => [href];
}

class DetailRefresh extends DetailEvent {
  final String href;

  const DetailRefresh(this.href);

  @override
  List<Object?> get props => [href];
}

class DetailReset extends DetailEvent {}

class DetailAddBookmark extends DetailEvent {
  final KomikDetailEntity detail;

  const DetailAddBookmark(this.detail);

  @override
  List<Object?> get props => [detail];
}

class DetailRemoveBookmark extends DetailEvent {
  final KomikDetailEntity detail;

  const DetailRemoveBookmark(this.detail);

  @override
  List<Object?> get props => [detail];
}

class DetailGetBookmarks extends DetailEvent {
  const DetailGetBookmarks();

  @override
  List<Object?> get props => [];
}
