import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/detail/domain/entities/komik_detail_entity.dart';

abstract class DetailRepository {
  const DetailRepository();

  ResultFuture<List<KomikDetailEntity>> getDetail(String slug);
  ResultFuture<List<GenreEntity>> getGenre(String slug);
  ResultFuture<List<ChapterEntity>> getChapter(String slug);
}
