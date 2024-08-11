import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/genre/domain/entities/genre_detail_entity.dart';

abstract class GenreRepository {
  const GenreRepository();

  ResultFuture<KomikGenreDetailEntity> getGenrePage(String href, int page);
  ResultFuture<List<KomikGenreDetailDataEntity>> getGenre(
    String href,
    int page,
  );
}
