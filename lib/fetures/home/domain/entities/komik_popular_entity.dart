import 'package:equatable/equatable.dart';

class KomikPopularEntity extends Equatable {
  const KomikPopularEntity({
    required this.title,
    required this.href,
    required this.genre,
    required this.year,
    required this.thumbnail,
  });

  final String title;
  final String href;
  final String genre;
  final String year;
  final String thumbnail;

  @override
  List<Object?> get props => [title, href, genre, year, thumbnail];
}
