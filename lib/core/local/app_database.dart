import 'dart:async';
import 'package:mangap/core/local/DAO/chapter_dao.dart';
import 'package:mangap/fetures/read/data/models/read_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:floor/floor.dart';
import 'package:mangap/core/local/DAO/detail_dao.dart';
import 'package:mangap/fetures/detail/data/models/komik_detail_model.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [KomikDetailModel, ReadModel])
abstract class AppDatabase extends FloorDatabase {
  DetailDao get detailDao;
  ChapterDao get chapterDao;
}
