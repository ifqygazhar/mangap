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

  Future<KomikDetailEntity> getDetail(String href);
  Future<List<GenreEntity>> getGenre(String href);
  Future<List<ChapterEntity>> getChapter(String href);
}

class DetailRemoteDataSourceImpl implements DetailRemoteDataSource {
  DetailRemoteDataSourceImpl({
    required http.Client client,
  }) : _client = client;

  final http.Client _client;

  @override
  Future<KomikDetailEntity> getDetail(String href) async {
    final url = Uri.parse("${ApiConstant.KOMIK_DETAIL}/$href");

    final response = await _client.get(url);

    final decode = jsonDecode(response.body) as ResultMap;

    if (response.statusCode != AppConstant.successfulHttpGetStatusCode) {
      throw ServerException(message: decode['status'] as String);
    }
    final listDetail = decode['data'] as Map<String, dynamic>;

    return KomikDetailModel.fromJson(listDetail);
  }

  @override
  Future<List<ChapterEntity>> getChapter(String href) async {
    final url = Uri.parse("${ApiConstant.KOMIK_DETAIL}/$href");

    final response = await _client.get(url);

    final decode = jsonDecode(response.body) as ResultMap;

    if (response.statusCode != AppConstant.successfulHttpGetStatusCode) {
      throw ServerException(message: decode['status'] as String);
    }
    final listChapter = decode['data']['chapter'] as List<dynamic>;

    return listChapter
        .map((komik) => ChapterModel.fromJson(komik as ResultMap))
        .toList();
  }

  @override
  Future<List<GenreEntity>> getGenre(String href) async {
    final url = Uri.parse("${ApiConstant.KOMIK_DETAIL}/$href");

    final response = await _client.get(url);

    final decode = jsonDecode(response.body) as ResultMap;

    if (response.statusCode != AppConstant.successfulHttpGetStatusCode) {
      throw ServerException(message: decode['status'] as String);
    }
    final listGenre = decode['data']['genre'] as List<dynamic>;

    return listGenre
        .map((komik) => GenreModel.fromJson(komik as ResultMap))
        .toList();
  }
}
