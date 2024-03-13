class KomikDetailEntity {
  const KomikDetailEntity({
    required this.title,
    required this.coverImg,
    required this.alternativeTitle,
    required this.released,
    required this.status,
    required this.totalChapter,
    required this.author,
    required this.type,
    required this.rating,
    required this.synopsis,
  });

  final String title;
  final String coverImg;
  final String alternativeTitle;
  final String released;
  final String status;
  final String totalChapter;
  final String author;
  final String type;
  final String rating;
  final String synopsis;
}

class GenreEntity {
  const GenreEntity({
    required this.name,
    required this.slug,
  });

  final String name;
  final String slug;
}

class ChapterEntity {
  const ChapterEntity({
    required this.number,
    required this.slug,
    required this.date,
  });

  final String number;
  final String slug;
  final String date;
}
