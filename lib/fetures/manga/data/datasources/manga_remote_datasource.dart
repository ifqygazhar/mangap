import 'dart:convert';

import 'package:mangap/core/constants/api_constant.dart';
import 'package:mangap/core/constants/app_constant.dart';
import 'package:mangap/core/errors/exception.dart';
import 'package:mangap/core/utils/manage_server.dart';
import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/manga/data/models/manga_model.dart';
import 'package:mangap/fetures/manga/domain/entities/manga_entity.dart';
import 'package:http/http.dart' as http;

abstract class MangaRemoteDataSource {
  Future<List<MangaEntity>> getAllManga(int page);
}

class MangaRemoteDataSourceImpl implements MangaRemoteDataSource {
  const MangaRemoteDataSourceImpl(
      {required http.Client client, required ApiConstant constant})
      : _client = client,
        _constant = constant;

  final http.Client _client;
  final ApiConstant _constant;

  @override
  Future<List<MangaEntity>> getAllManga(int page) async {
    final response = await NetworkHelper.fetchWithFallback(
        "${_constant.allManga}/$page",
        "${_constant.backupAllManga}/$page",
        _client);

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
