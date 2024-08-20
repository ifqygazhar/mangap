import 'package:floor/floor.dart';
import 'package:mangap/fetures/read/data/models/read_model.dart';

@dao
abstract class ChapterDao {
  @insert
  Future<void> saveChapter(ReadModel chapter);

  @delete
  Future<void> deleteSavedChapter(ReadModel chapter);

  @Query('SELECT * FROM chapter')
  Future<List<ReadModel>> getChapter();
}
