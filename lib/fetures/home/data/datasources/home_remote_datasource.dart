import 'dart:convert';

import 'package:mangap/core/constants/api_endpoint.dart';
import 'package:mangap/core/constants/app_constant.dart';
import 'package:mangap/core/errors/exception.dart';
import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/home/data/models/komik_popular_model.dart';
import 'package:mangap/fetures/home/data/models/komik_recommended_model.dart';
import 'package:http/http.dart' as http;

abstract class HomeRemoteDataSource {
  const HomeRemoteDataSource();

  Future<List<KomikPopularModel>> getPopular();
  Future<List<KomikRecommendedModel>> getRecommended();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl({
    required http.Client client,
  }) : _client = client;

  final http.Client _client;

  @override
  Future<List<KomikPopularModel>> getPopular() async {
    final url = Uri.parse(ApiConstant.KOMIK_POPULAR);

    final response = await _client.get(url);

    final decode = jsonDecode(response.body) as ResultMap;

    if (response.statusCode != AppConstant.successfulHttpGetStatusCode) {
      throw ServerException(message: decode['message'] as String);
    }
    final listPopularKomik = decode['data'] as List<dynamic>;
    return listPopularKomik
        .map((komik) => KomikPopularModel.fromJson(komik as ResultMap))
        .toList();
  }

  @override
  Future<List<KomikRecommendedModel>> getRecommended() async {
    final url = Uri.parse(ApiConstant.KOMIK_RECOMENDED);

    final response = await _client.get(url);

    final decode = jsonDecode(response.body) as ResultMap;

    if (response.statusCode != AppConstant.successfulHttpGetStatusCode) {
      throw ServerException(message: decode['message'] as String);
    } else if (decode['data'] == []) {
      throw const ServerException(message: "Tidak ada komik lagi");
    }

    final listRecommendedKomik = decode['data'] as List<dynamic>;

    return listRecommendedKomik
        .map((komik) => KomikRecommendedModel.fromJson(komik as ResultMap))
        .toList();
  }
}
