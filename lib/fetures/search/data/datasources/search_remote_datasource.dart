import 'dart:convert';

import 'package:mangap/core/constants/api_constant.dart';
import 'package:mangap/core/constants/app_constant.dart';
import 'package:mangap/core/errors/exception.dart';
import 'package:mangap/core/utils/manage_server.dart';
import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/search/data/models/search_model.dart';
import 'package:mangap/fetures/search/domain/entities/search_entity.dart';
import 'package:http/http.dart' as http;

abstract class SearchRemoteDataSource {
  Future<List<SearchEntity>> search(String keyword);
}

class SearchRemoteDatasourceImpl implements SearchRemoteDataSource {
  const SearchRemoteDatasourceImpl(
      {required http.Client client, required ApiConstant constant})
      : _client = client,
        _constant = constant;

  final http.Client _client;
  final ApiConstant _constant;

  @override
  Future<List<SearchEntity>> search(String keyword) async {
    final response = await NetworkHelper.fetchWithFallback(
        "${_constant.search}$keyword",
        "${_constant.backupSearch}$keyword",
        _client);

    final decode = jsonDecode(response.body) as ResultMap;

    if (response.statusCode != AppConstant.successfulHttpGetStatusCode) {
      throw ServerException(message: decode['status'] as String);
    }
    final data = decode['data'] as List<dynamic>;

    return data
        .map((komik) => SearchModel.fromJson(komik as ResultMap))
        .toList();
  }
}
