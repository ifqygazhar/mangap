import 'package:equatable/equatable.dart';

class KomikEntity extends Equatable {
  const KomikEntity(
    this.completed, {
    required this.coverImg,
    required this.title,
    required this.type,
    required this.latestChapter,
    required this.rating,
    required this.slug,
  });

  final String coverImg;
  final String title;
  final String type;
  final String latestChapter;
  final String rating;
  final String slug;
  final bool? completed;

  @override
  List<Object?> get props =>
      [coverImg, title, type, latestChapter, rating, slug, completed];
}
