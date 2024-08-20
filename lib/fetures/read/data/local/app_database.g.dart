// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ChapterDao? _chapterDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `chapter` (`title` TEXT NOT NULL, `prev` TEXT, `next` TEXT, `panel` TEXT NOT NULL, PRIMARY KEY (`title`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ChapterDao get chapterDao {
    return _chapterDaoInstance ??= _$ChapterDao(database, changeListener);
  }
}

class _$ChapterDao extends ChapterDao {
  _$ChapterDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _readModelInsertionAdapter = InsertionAdapter(
            database,
            'chapter',
            (ReadModel item) => <String, Object?>{
                  'title': item.title,
                  'prev': item.prev,
                  'next': item.next,
                  'panel': _panelTypeConverter.encode(item.panel)
                }),
        _readModelDeletionAdapter = DeletionAdapter(
            database,
            'chapter',
            ['title'],
            (ReadModel item) => <String, Object?>{
                  'title': item.title,
                  'prev': item.prev,
                  'next': item.next,
                  'panel': _panelTypeConverter.encode(item.panel)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ReadModel> _readModelInsertionAdapter;

  final DeletionAdapter<ReadModel> _readModelDeletionAdapter;

  @override
  Future<List<ReadModel>> getChapter() async {
    return _queryAdapter.queryList('SELECT * FROM chapter',
        mapper: (Map<String, Object?> row) => ReadModel(
            title: row['title'] as String,
            prev: row['prev'] as String?,
            next: row['next'] as String?,
            panel: _panelTypeConverter.decode(row['panel'] as String)));
  }

  @override
  Future<void> saveChapter(ReadModel chapter) async {
    await _readModelInsertionAdapter.insert(chapter, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteSavedChapter(ReadModel chapter) async {
    await _readModelDeletionAdapter.delete(chapter);
  }
}

// ignore_for_file: unused_element
final _panelTypeConverter = PanelTypeConverter();
