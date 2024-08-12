import 'dart:convert';

import 'package:mangap/core/constants/api_endpoint.dart';
import 'package:mangap/core/constants/app_constant.dart';
import 'package:mangap/core/errors/exception.dart';
import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/manga/data/models/manga_model.dart';
import 'package:mangap/fetures/manga/domain/entities/manga_entity.dart';
import 'package:http/http.dart' as http;

abstract class MangaRemoteDataSource {
  Future<List<MangaEntity>> getAllManga(int page);
}

class MangaRemoteDataSourceImpl implements MangaRemoteDataSource {
  const MangaRemoteDataSourceImpl({required http.Client client})
      : _client = client;

  final http.Client _client;

  @override
  Future<List<MangaEntity>> getAllManga(int page) async {
    final url = Uri.parse("${ApiConstant.ALL_MANGA}/$page");

    final response = await _client.get(url);

    final decode = jsonDecode(response.body) as ResultMap;

    if (response.statusCode != AppConstant.successfulHttpGetStatusCode) {
      throw ServerException(message: decode['status'] as String);
    }
    final manga = decode['data']['comics'] as List<dynamic>;
    return manga
        .map((komik) => MangaModel.fromJson(komik as ResultMap))
        .toList();
  }
}
