import 'package:equatable/equatable.dart';

class KomikGenreEntity extends Equatable{
  const KomikGenreEntity({
    required this.title,
    required this.href,
  });

  final String title;
  final String href;

  @override
  List<Object?> get props => [title,href];
}
