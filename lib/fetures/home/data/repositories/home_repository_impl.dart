import 'package:dartz/dartz.dart';
import 'package:mangap/core/errors/exception.dart';
import 'package:mangap/core/errors/failures.dart';
import 'package:mangap/core/services/network_info.dart';
import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/home/data/datasources/home_remote_datasource.dart';
import 'package:mangap/fetures/home/domain/entities/komik_entity.dart';
import 'package:mangap/fetures/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({
    required HomeRemoteDataSource dataSource,
    required NetworkInfo networkInfo,
  })  : _dataSource = dataSource,
        _networkInfo = networkInfo;

  final HomeRemoteDataSource _dataSource;
  final NetworkInfo _networkInfo;

  @override
  ResultFuture<List<KomikEntity>> getPopular() async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(InternetFailure());
      }
      final result = await _dataSource.getPopular();
      return Right(result);
    } on ServerException catch (e) {
      return left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<KomikEntity>> getListByUpdate(
      {required String page}) async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(InternetFailure());
      }
      final result = await _dataSource.getListByUpdate(page);
      return Right(result);
    } on ServerException catch (e) {
      return left(ServerFailure.fromException(e));
    }
  }
}
