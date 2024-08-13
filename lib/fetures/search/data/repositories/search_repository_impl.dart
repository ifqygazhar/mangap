import 'package:dartz/dartz.dart';
import 'package:mangap/core/errors/exception.dart';
import 'package:mangap/core/errors/failures.dart';
import 'package:mangap/core/services/network_info.dart';
import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/search/data/datasources/search_remote_datasource.dart';
import 'package:mangap/fetures/search/domain/entities/search_entity.dart';
import 'package:mangap/fetures/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  const SearchRepositoryImpl(
      {required NetworkInfo networkInfo,
      required SearchRemoteDataSource dataSource})
      : _networkInfo = networkInfo,
        _dataSource = dataSource;

  final NetworkInfo _networkInfo;
  final SearchRemoteDataSource _dataSource;

  @override
  ResultFuture<List<SearchEntity>> search(String keyword) async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(InternetFailure());
      }
      final result = await _dataSource.search(keyword);
      return Right(result);
    } on ServerException catch (e) {
      return left(ServerFailure.fromException(e));
    }
  }
}
