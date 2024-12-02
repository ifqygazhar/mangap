import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mangap/core/constants/api_constant.dart';
import 'package:mangap/core/constants/app_constant.dart';
import 'package:mangap/core/errors/exception.dart';
import 'package:mangap/core/utils/manage_server.dart';
import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/home/data/models/komik_genre_model.dart';
import 'package:mangap/fetures/home/data/models/komik_popular_model.dart';
import 'package:mangap/fetures/home/data/models/komik_recommended_model.dart';
import 'package:mangap/fetures/home/domain/entities/komik_genre.dart';

abstract class HomeRemoteDataSource {
  const HomeRemoteDataSource();

  Future<List<KomikPopularModel>> getPopular();
  Future<List<KomikRecommendedModel>> getRecommended();
  Future<List<KomikGenreEntity>> getGenre();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl({required http.Client client}) : _client = client;

  final http.Client _client;

  @override
  Future<List<KomikPopularModel>> getPopular() async {
    final response = await NetworkHelper.fetchWithFallback(
      "${ApiConstant.komikPopular}",
      "${ApiConstant.backupKomikPopular}",
      _client,
    );

    final decode = jsonDecode(response.body) as ResultMap;

    if (response.statusCode != AppConstant.successfulHttpGetStatusCode) {
      throw ServerException(message: decode['status'] as String);
    }

    final listPopularKomik = decode['data'] as List<dynamic>;
    return listPopularKomik
        .map((komik) => KomikPopularModel.fromJson(komik as ResultMap))
        .toList();
  }

  @override
  Future<List<KomikRecommendedModel>> getRecommended() async {
    final response = await NetworkHelper.fetchWithFallback(
      "${ApiConstant.komikRecomended}",
      "${ApiConstant.backupKomikRecomended}",
      _client,
    );

    final decode = jsonDecode(response.body) as ResultMap;

    if (response.statusCode != AppConstant.successfulHttpGetStatusCode) {
      throw ServerException(message: decode['status'] as String);
    }

    final listRecommendedKomik = decode['data'] as List<dynamic>;

    return listRecommendedKomik
        .map((komik) => KomikRecommendedModel.fromJson(komik as ResultMap))
        .toList();
  }

  @override
  Future<List<KomikGenreModel>> getGenre() async {
    final response = await NetworkHelper.fetchWithFallback(
      "${ApiConstant.genre}",
      "${ApiConstant.backupGenre}",
      _client,
    );

    final decode = jsonDecode(response.body) as ResultMap;

    if (response.statusCode != AppConstant.successfulHttpGetStatusCode) {
      throw ServerException(message: decode['status'] as String);
    }

    final listGenre = decode['data'] as List<dynamic>;
    return listGenre.map((genre) => KomikGenreModel.fromJson(genre)).toList();
  }
}
