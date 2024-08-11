part of 'genre_detail_bloc.dart';

sealed class GenreDetailEvent extends Equatable {
  const GenreDetailEvent();

  @override
  List<Object> get props => [];
}

class GenreDetailGetPage extends GenreDetailEvent {
  final int page;
  final String href;

  const GenreDetailGetPage(this.href, this.page);

  @override
  List<Object> get props => [href, page];
}

class GenreDetailGetDataGenre extends GenreDetailEvent {
  final int page;
  final String href;

  const GenreDetailGetDataGenre(this.href, this.page);

  @override
  List<Object> get props => [href, page];
}

class GenreDetailReset extends GenreDetailEvent {}
