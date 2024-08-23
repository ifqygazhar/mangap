part of 'read_bloc.dart';

sealed class ReadEvent extends Equatable {
  const ReadEvent();

  @override
  List<Object> get props => [];
}

class ReadGetChapter extends ReadEvent {
  final String href;

  const ReadGetChapter(this.href);

  @override
  List<Object> get props => [href];
}

class ReadGetSaveChapter extends ReadEvent {}

class ReadSaveChapter extends ReadEvent {
  final ReadEntity chapter;
  const ReadSaveChapter(this.chapter);

  @override
  List<Object> get props => [chapter];
}

class ReadRemoveChapter extends ReadEvent {
  final ReadEntity chapter;
  const ReadRemoveChapter(this.chapter);

  @override
  List<Object> get props => [chapter];
}

class ReadLoadingEvent extends ReadEvent {}
