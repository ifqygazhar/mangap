import 'dart:async';
import 'package:mangap/fetures/read/data/local/DAO/chapter_dao.dart';
import 'package:mangap/fetures/read/data/models/read_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:floor/floor.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [ReadModel])
abstract class AppDatabase extends FloorDatabase {
  ChapterDao get chapterDao;
}
