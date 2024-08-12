part of 'manga_bloc.dart';

sealed class MangaEvent extends Equatable {
  const MangaEvent();

  @override
  List<Object> get props => [];
}

class Manga extends MangaEvent {
  final int page;
  const Manga(this.page);

  @override
  List<Object> get props => [page];
}

class MangaReset extends MangaEvent {}
