import 'dart:convert';

import 'package:mangap/core/constants/api_endpoint.dart';
import 'package:mangap/core/constants/app_constant.dart';
import 'package:mangap/core/errors/exception.dart';
import 'package:mangap/core/utils/manage_server.dart';
import 'package:mangap/core/utils/typedef.dart';
import 'package:mangap/fetures/read/data/models/read_model.dart';
import 'package:mangap/fetures/read/domain/entities/read_entity.dart';
import 'package:http/http.dart' as http;

abstract class ReadRemoteDataSource {
  Future<List<ReadEntity>> read(String href);
}

class ReadRempteDataSourceImpl implements ReadRemoteDataSource {
  const ReadRempteDataSourceImpl({required http.Client client})
      : _client = client;

  final http.Client _client;

  @override
  Future<List<ReadEntity>> read(String href) async {
    final response = await NetworkHelper.fetchWithFallback(
        "${ApiConstant.READ}/$href",
        "${ApiConstant.BACKUP_READ}/$href",
        _client);

    final decode = jsonDecode(response.body) as ResultMap;

    if (response.statusCode != AppConstant.successfulHttpGetStatusCode) {
      throw ServerException(message: decode['status'] as String);
    }
    final read = decode['data'] as List<dynamic>;

    return read.map((komik) => ReadModel.fromJson(komik as ResultMap)).toList();
  }
}
