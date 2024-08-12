import 'package:dartz/dartz.dart';
import 'package:mangap/core/errors/exception.dart';
import 'package:mangap/core/errors/failures.dart';
import 'package:mangap/core/services/network_info.dart';
import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/manga/data/datasources/manga_remote_datasource.dart';
import 'package:mangap/fetures/manga/domain/entities/manga_entity.dart';
import 'package:mangap/fetures/manga/domain/repositories/manga_repository.dart';

class MangaRepositoryImpl implements MangaRepository {
  const MangaRepositoryImpl({
    required MangaRemoteDataSource dataSource,
    required NetworkInfo networkInfo,
  })  : _dataSource = dataSource,
        _networkInfo = networkInfo;

  final MangaRemoteDataSource _dataSource;
  final NetworkInfo _networkInfo;

  @override
  ResultFuture<List<MangaEntity>> getAllManga(
    int page,
  ) async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(InternetFailure());
      }
      final result = await _dataSource.getAllManga(page);
      return Right(result);
    } on ServerException catch (e) {
      return left(ServerFailure.fromException(e));
    }
  }
}
