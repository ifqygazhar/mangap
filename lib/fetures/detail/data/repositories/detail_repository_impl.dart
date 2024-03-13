import 'package:dartz/dartz.dart';
import 'package:mangap/core/errors/exception.dart';
import 'package:mangap/core/errors/failures.dart';
import 'package:mangap/core/services/network_info.dart';
import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/detail/data/datasources/detail_remote_datasoruce.dart';
import 'package:mangap/fetures/detail/domain/entities/komik_detail_entity.dart';
import 'package:mangap/fetures/detail/domain/repositories/detail_repository.dart';

class DetailRepositoryImpl implements DetailRepository {
  DetailRepositoryImpl({
    required DetailRemoteDataSource dataSource,
    required NetworkInfo networkInfo,
  })  : _dataSource = dataSource,
        _networkInfo = networkInfo;

  final DetailRemoteDataSource _dataSource;
  final NetworkInfo _networkInfo;

  @override
  ResultFuture<List<ChapterEntity>> getChapter(String slug) async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(InternetFailure());
      }
      final result = await _dataSource.getChapter(slug);
      return Right(result);
    } on ServerException catch (e) {
      return left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<KomikDetailEntity>> getDetail(String slug) async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(InternetFailure());
      }
      final result = await _dataSource.getDetail(slug);
      return Right(result);
    } on ServerException catch (e) {
      return left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<GenreEntity>> getGenre(String slug) async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(InternetFailure());
      }
      final result = await _dataSource.getGenre(slug);
      return Right(result);
    } on ServerException catch (e) {
      return left(ServerFailure.fromException(e));
    }
  }
}
