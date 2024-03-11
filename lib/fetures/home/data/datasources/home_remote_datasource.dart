import 'dart:convert';

import 'package:mangap/core/constants/api_endpoint.dart';
import 'package:mangap/core/constants/app_constant.dart';
import 'package:mangap/core/errors/exception.dart';
import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/home/data/models/komik_model.dart';
import 'package:http/http.dart' as http;

abstract class HomeRemoteDataSource {
  const HomeRemoteDataSource();

  Future<List<KomikModel>> getPopular();
  Future<List<KomikModel>> getLatest();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl({
    required http.Client client,
  }) : _client = client;

  final http.Client _client;

  @override
  Future<List<KomikModel>> getLatest() async {
    final url = Uri.parse(KOMIK_HOME);

    final response = await _client.get(url);

    final decode = jsonDecode(response.body) as ResultMap;

    if (response.statusCode != AppConstant.successfulHttpGetStatusCode) {
      throw ServerException(message: decode['message'] as String);
    }
    final listHotKomik = decode['data']['latest'] as List<dynamic>;
    return listHotKomik
        .map((komik) => KomikModel.fromJson(komik as ResultMap))
        .toList();
  }

  @override
  Future<List<KomikModel>> getPopular() async {
    final url = Uri.parse(KOMIK_HOME);

    final response = await _client.get(url);

    final decode = jsonDecode(response.body) as ResultMap;

    if (response.statusCode != AppConstant.successfulHttpGetStatusCode) {
      throw ServerException(message: decode['message'] as String);
    }
    final listHotKomik = decode['data']['popular'] as List<dynamic>;
    return listHotKomik
        .map((komik) => KomikModel.fromJson(komik as ResultMap))
        .toList();
  }
}
