import 'package:dartz/dartz.dart';
import 'package:mangap/core/errors/exception.dart';
import 'package:mangap/core/errors/failures.dart';
import 'package:mangap/core/local/app_database.dart';
import 'package:mangap/core/services/network_info.dart';
import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/read/data/datasources/read_remote_datasource.dart';
import 'package:mangap/fetures/read/data/models/read_model.dart';
import 'package:mangap/fetures/read/domain/entities/read_entity.dart';
import 'package:mangap/fetures/read/domain/repositories/read_repository.dart';

class ReadRepositoryImpl implements ReadRepository {
  const ReadRepositoryImpl({
    required NetworkInfo networkInfo,
    required ReadRemoteDataSource dataSource,
    required AppDatabase database,
  })  : _networkInfo = networkInfo,
        _dataSource = dataSource,
        _database = database;

  final NetworkInfo _networkInfo;
  final ReadRemoteDataSource _dataSource;
  final AppDatabase _database;

  @override
  ResultFuture<List<ReadEntity>> read(String href) async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(InternetFailure());
      }
      final result = await _dataSource.read(href);
      return Right(result);
    } on ServerException catch (e) {
      return left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> deleteSaveChapter(ReadEntity read) async {
    try {
      final result = await _database.chapterDao
          .deleteSavedChapter(ReadModel.fromEntity(read));
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> saveChapter(ReadEntity read) async {
    try {
      await _database.chapterDao.saveChapter(ReadModel.fromEntity(read));
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<ReadEntity>> getSaveChapter() async {
    try {
      final result = await _database.chapterDao.getChapter();
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure.fromException(e));
    }
  }
}
