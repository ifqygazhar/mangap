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
      final response = await client.get(
        Uri.parse(primaryUrl),
        headers: {
          'Referer': 'https://komikcast.cz/',
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36',
          'Accept':
              'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
          'Accept-Language': 'en-US,en;q=0.9'
        },
      );
      if (response.statusCode == AppConstant.successfulHttpGetStatusCode) {
        return response;
      } else {
        throw const ServerException(
            message: "Server Utama Down Mengalihkan Ke Backup...");
      }
    } catch (e) {
      // Jika terjadi error, coba request ke URL backup
      final response = await client.get(
        Uri.parse(backupUrl),
        headers: {
          'Referer': 'https://komikcast.cz/',
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36',
          'Accept':
              'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
          'Accept-Language': 'en-US,en;q=0.9'
        },
      );
      if (response.statusCode == AppConstant.successfulHttpGetStatusCode) {
        return response;
      } else {
        throw const ServerException(
            message: "Server utama dan backup sedang down");
      }
    }
  }
}
