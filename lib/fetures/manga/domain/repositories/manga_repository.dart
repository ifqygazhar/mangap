import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/manga/domain/entities/manga_entity.dart';

abstract class MangaRepository {
  const MangaRepository();

  ResultFuture<List<MangaEntity>> getAllManga(int page);
}
