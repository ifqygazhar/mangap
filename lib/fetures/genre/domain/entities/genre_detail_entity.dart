class KomikGenreDetailEntity {
  const KomikGenreDetailEntity({
    required this.current_page,
    required this.length_page,
  });
  final int current_page, length_page;
}

class KomikGenreDetailDataEntity {
  const KomikGenreDetailDataEntity({
    required this.title,
    required this.chapter,
    required this.type,
    required this.href,
    required this.rating,
    required this.thumbnail,
  });
  final String title;
  final String chapter;
  final String type;
  final String href;
  final String rating;
  final String thumbnail;
}
