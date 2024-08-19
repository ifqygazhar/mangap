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

  DetailDao? _detailDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `komik_detail` (`href` TEXT, `title` TEXT NOT NULL, `altTitle` TEXT NOT NULL, `updatedOn` TEXT NOT NULL, `rating` TEXT NOT NULL, `status` TEXT NOT NULL, `type` TEXT NOT NULL, `released` TEXT NOT NULL, `author` TEXT NOT NULL, `description` TEXT NOT NULL, `thumbnail` TEXT NOT NULL, PRIMARY KEY (`href`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  DetailDao get detailDao {
    return _detailDaoInstance ??= _$DetailDao(database, changeListener);
  }
}

class _$DetailDao extends DetailDao {
  _$DetailDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _komikDetailModelInsertionAdapter = InsertionAdapter(
            database,
            'komik_detail',
            (KomikDetailModel item) => <String, Object?>{
                  'href': item.href,
                  'title': item.title,
                  'altTitle': item.altTitle,
                  'updatedOn': item.updatedOn,
                  'rating': item.rating,
                  'status': item.status,
                  'type': item.type,
                  'released': item.released,
                  'author': item.author,
                  'description': item.description,
                  'thumbnail': item.thumbnail
                }),
        _komikDetailModelDeletionAdapter = DeletionAdapter(
            database,
            'komik_detail',
            ['href'],
            (KomikDetailModel item) => <String, Object?>{
                  'href': item.href,
                  'title': item.title,
                  'altTitle': item.altTitle,
                  'updatedOn': item.updatedOn,
                  'rating': item.rating,
                  'status': item.status,
                  'type': item.type,
                  'released': item.released,
                  'author': item.author,
                  'description': item.description,
                  'thumbnail': item.thumbnail
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<KomikDetailModel> _komikDetailModelInsertionAdapter;

  final DeletionAdapter<KomikDetailModel> _komikDetailModelDeletionAdapter;

  @override
  Future<List<KomikDetailModel>> getDetails() async {
    return _queryAdapter.queryList('SELECT * FROM komik_detail',
        mapper: (Map<String, Object?> row) => KomikDetailModel(
            href: row['href'] as String?,
            title: row['title'] as String,
            altTitle: row['altTitle'] as String,
            updatedOn: row['updatedOn'] as String,
            rating: row['rating'] as String,
            status: row['status'] as String,
            type: row['type'] as String,
            released: row['released'] as String,
            author: row['author'] as String,
            description: row['description'] as String,
            thumbnail: row['thumbnail'] as String));
  }

  @override
  Future<void> saveDetail(KomikDetailModel detail) async {
    await _komikDetailModelInsertionAdapter.insert(
        detail, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteSavedDetail(KomikDetailModel detail) async {
    await _komikDetailModelDeletionAdapter.delete(detail);
  }
}
