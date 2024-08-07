import 'package:equatable/equatable.dart';

class KomikRecommendedEntity extends Equatable {
  const KomikRecommendedEntity({
    required this.title,
    required this.href,
    required this.rating,
    required this.thumbnail,
    required this.chapter,
    required this.type,
  });

  final String title;
  final String href;
  final String rating;
  final String thumbnail;
  final String chapter;
  final String type;

  @override
  List<Object?> get props => [title, href, rating, thumbnail, chapter, type];
}
