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
