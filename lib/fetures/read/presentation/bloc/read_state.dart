part of 'read_bloc.dart';

enum ReadStatus { loading, error, success }

class ReadState extends Equatable {
  const ReadState({
    this.read = const [],
    this.saveRead = const [],
    this.errorMessage = '',
    this.status = ReadStatus.loading,
    this.image = const ReadEntity(
      title: '',
      prev: '',
      next: '',
      panel: [],
    ),
    this.isFullscreen = false,
  });

  final List<ReadEntity> read;
  final List<ReadEntity> saveRead;
  final String errorMessage;
  final ReadStatus status;
  final ReadEntity image;
  final bool isFullscreen;

  ReadState copyWith({
    List<ReadEntity>? read,
    String? errorMessage,
    ReadStatus? status,
    ReadEntity? image,
    List<ReadEntity>? saveRead,
    bool? isFullscreen,
  }) {
    return ReadState(
      read: read ?? this.read,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      image: image ?? this.image,
      saveRead: saveRead ?? this.saveRead,
      isFullscreen: isFullscreen ?? this.isFullscreen,
    );
  }

  @override
  List<Object> get props =>
      [read, errorMessage, status, image, saveRead, isFullscreen];
}
