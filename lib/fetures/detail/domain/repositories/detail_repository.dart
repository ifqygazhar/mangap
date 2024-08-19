import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/detail/domain/entities/komik_detail_entity.dart';

abstract class DetailRepository {
  const DetailRepository();

  ResultFuture<KomikDetailEntity> getDetail(String href);
  ResultFuture<List<GenreEntity>> getGenre(String href);
  ResultFuture<List<ChapterEntity>> getChapter(String href);
  //sqflite
  ResultFuture<List<KomikDetailEntity>> getSavedDetail(String href);
  ResultFuture<void> saveDetail(KomikDetailEntity detail);
  ResultFuture<void> deleteSaveDetail(KomikDetailEntity detail);
}
