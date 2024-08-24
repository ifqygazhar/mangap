import 'package:http/http.dart' as http;
import 'package:mangap/core/constants/app_constant.dart';
import 'package:mangap/core/errors/exception.dart';

class NetworkHelper {
  static Future<http.Response> fetchWithFallback(
    String primaryUrl,
    String backupUrl,
    http.Client client,
  ) async {
    try {
      // Coba request ke URL utama
      final response = await client.get(Uri.parse(primaryUrl));
      if (response.statusCode == AppConstant.successfulHttpGetStatusCode) {
        return response;
      } else {
        throw const ServerException(
            message: "Server Utama Down Mengalihkan Ke Backup...");
      }
    } catch (e) {
      // Jika terjadi error, coba request ke URL backup
      final response = await client.get(Uri.parse(backupUrl));
      if (response.statusCode == AppConstant.successfulHttpGetStatusCode) {
        return response;
      } else {
        throw const ServerException(
            message: "Server utama dan backup sedang down");
      }
    }
  }
}
