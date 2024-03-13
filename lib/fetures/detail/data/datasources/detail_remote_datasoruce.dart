import 'dart:convert';

import 'package:mangap/core/constants/api_endpoint.dart';
import 'package:mangap/core/constants/app_constant.dart';
import 'package:mangap/core/errors/exception.dart';
import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/detail/data/models/komik_detail_model.dart';
import 'package:mangap/fetures/detail/domain/entities/komik_detail_entity.dart';
import 'package:http/http.dart' as http;

abstract class DetailRemoteDataSource {
  const DetailRemoteDataSource();

  Future<List<KomikDetailEntity>> getDetail(String slug);
  Future<List<GenreEntity>> getGenre(String slug);
  Future<List<ChapterEntity>> getChapter(String slug);
}

class DetailRemoteDataSourceImpl implements DetailRemoteDataSource {
  DetailRemoteDataSourceImpl({
    required http.Client client,
  }) : _client = client;

  final http.Client _client;

  @override
  Future<List<KomikDetailEntity>> getDetail(String slug) async {
    final url = Uri.parse("${ApiConstant.KOMIK_DETAIL}/$slug");

    final response = await _client.get(url);

    final decode = jsonDecode(response.body) as ResultMap;

    if (response.statusCode != AppConstant.successfulHttpGetStatusCode) {
      throw ServerException(message: decode['message'] as String);
    }
    final listDetail = decode['data'] as List<dynamic>;
    return listDetail
        .map((komik) => KomikDetailModel.fromJson(komik as ResultMap))
        .toList();
  }

  @override
  Future<List<ChapterEntity>> getChapter(String slug) async {
    final url = Uri.parse("${ApiConstant.KOMIK_DETAIL}/$slug");

    final response = await _client.get(url);

    final decode = jsonDecode(response.body) as ResultMap;

    if (response.statusCode != AppConstant.successfulHttpGetStatusCode) {
      throw ServerException(message: decode['message'] as String);
    }
    final listChapter = decode['data']['chapters'] as List<dynamic>;
    return listChapter
        .map((komik) => ChapterModel.fromJson(komik as ResultMap))
        .toList();
  }

  @override
  Future<List<GenreEntity>> getGenre(String slug) async {
    final url = Uri.parse("${ApiConstant.KOMIK_DETAIL}/$slug");

    final response = await _client.get(url);

    final decode = jsonDecode(response.body) as ResultMap;

    if (response.statusCode != AppConstant.successfulHttpGetStatusCode) {
      throw ServerException(message: decode['message'] as String);
    }
    final listGenre = decode['data']['genres'] as List<dynamic>;
    return listGenre
        .map((komik) => GenreModel.fromJson(komik as ResultMap))
        .toList();
  }
}
