import 'dart:convert';

import 'package:mangap/core/constants/api_endpoint.dart';
import 'package:mangap/core/constants/app_constant.dart';
import 'package:mangap/core/errors/exception.dart';
import 'package:mangap/core/utils/manage_server.dart';
import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/genre/data/models/komik_genre_detail_model.dart';
import 'package:mangap/fetures/genre/domain/entities/genre_detail_entity.dart';
import 'package:http/http.dart' as http;

abstract class GenreRemoteDatasource {
  const GenreRemoteDatasource();

  Future<KomikGenreDetailEntity> getPage(String href, int page);
  Future<List<KomikGenreDetailDataEntity>> getGenre(String href, int page);
}

class GenreRemoteDataSourceImpl implements GenreRemoteDatasource {
  const GenreRemoteDataSourceImpl({required http.Client client})
      : _client = client;

  final http.Client _client;

  @override
  Future<List<KomikGenreDetailDataEntity>> getGenre(
    String href,
    int page,
  ) async {
    final response = await NetworkHelper.fetchWithFallback(
      "${ApiConstant.GENRE_DETAIL}$href$page",
      "${ApiConstant.BACKUP_GENRE_DETAIL}$href$page",
      _client,
    );

    final decode = jsonDecode(response.body) as ResultMap;

    if (response.statusCode != AppConstant.successfulHttpGetStatusCode) {
      throw ServerException(message: decode['status'] as String);
    }
    final listGenre = decode['data']['data'] as List<dynamic>;

    return listGenre
        .map((komik) => KomikGenreDetailDataModel.fromJson(komik as ResultMap))
        .toList();
  }

  @override
  Future<KomikGenreDetailEntity> getPage(String href, int page) async {
    final response = await NetworkHelper.fetchWithFallback(
      "${ApiConstant.GENRE_DETAIL}$href$page",
      "${ApiConstant.BACKUP_GENRE_DETAIL}$href$page",
      _client,
    );

    final decode = jsonDecode(response.body) as ResultMap;

    if (response.statusCode != AppConstant.successfulHttpGetStatusCode) {
      throw ServerException(message: decode['status'] as String);
    }
    final pageData = decode['data'] as ResultMap;
    return KomikGenreDetailModel.fromJson(pageData);
  }
}
