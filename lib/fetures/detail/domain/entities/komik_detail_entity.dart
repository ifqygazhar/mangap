class KomikDetailEntity {
  const KomikDetailEntity({
    required this.title,
    required this.altTitle,
    required this.updatedOn,
    required this.rating,
    required this.status,
    required this.type,
    required this.released,
    required this.author,
    required this.description,
    required this.thumbnail,
  });

  final String title;
  final String altTitle;
  final String updatedOn;
  final String rating;
  final String status;
  final String type;
  final String released;
  final String author;
  final String description;
  final String thumbnail;
}

class GenreEntity {
  const GenreEntity({
    required this.title,
    required this.href,
  });

  final String title;
  final String href;
}

class ChapterEntity {
  const ChapterEntity({
    required this.title,
    required this.href,
    required this.date,
  });

  final String title;
  final String href;
  final String date;
}
