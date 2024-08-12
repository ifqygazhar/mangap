import 'package:dartz/dartz.dart';
import 'package:mangap/core/errors/exception.dart';
import 'package:mangap/core/errors/failures.dart';
import 'package:mangap/core/services/network_info.dart';
import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/genre/data/datasources/genre_remote_datasource.dart';
import 'package:mangap/fetures/genre/domain/entities/genre_detail_entity.dart';
import 'package:mangap/fetures/genre/domain/repositories/genre_repository.dart';

class GenreRepositoryImpl implements GenreRepository {
  const GenreRepositoryImpl({
    required GenreRemoteDatasource dataSource,
    required NetworkInfo networkInfo,
  })  : _dataSource = dataSource,
        _networkInfo = networkInfo;

  final GenreRemoteDatasource _dataSource;
  final NetworkInfo _networkInfo;

  @override
  ResultFuture<List<KomikGenreDetailDataEntity>> getGenre(
    String href,
    int page,
  ) async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(InternetFailure());
      }
      final result = await _dataSource.getGenre(href, page);
      return Right(result);
    } on ServerException catch (e) {
      return left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<KomikGenreDetailEntity> getGenrePage(
    String href,
    int page,
  ) async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(InternetFailure());
      }
      final result = await _dataSource.getPage(href, page);
      return Right(result);
    } on ServerException catch (e) {
      return left(ServerFailure.fromException(e));
    }
  }
}
