import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;

class CustomFileServiceResponse implements FileServiceResponse {
  final Map<String, String> headers;

  final List<int> body;

  final int _statusCode;

  CustomFileServiceResponse({
    required this.body,
    required this.headers,
    required int statusCode,
  }) : _statusCode = statusCode;

  @override
  Stream<List<int>> get content => Stream.value(body);

  @override
  int? get contentLength => body.length;

  @override
  String? get eTag => headers['etag'];

  @override
  String get fileExtension {
    if (headers.containsKey('content-type')) {
      final contentType = headers['content-type']!;
      final extension = _getExtensionFromContentType(contentType);
      if (extension != null) {
        return extension;
      }
    }
    return 'jpg'; // Default extension jika tidak dapat ditentukan
  }

  @override
  int get statusCode => _statusCode;

  @override
  DateTime get validTill {
    if (headers.containsKey('cache-control')) {
      final cacheControl = headers['cache-control']!;
      final maxAgeMatch = RegExp(r'max-age=(\d+)').firstMatch(cacheControl);
      if (maxAgeMatch != null) {
        final maxAge = int.parse(maxAgeMatch.group(1)!);
        return DateTime.now().add(Duration(seconds: maxAge));
      }
    }
    if (headers.containsKey('expires')) {
      final expires = headers['expires']!;
      try {
        final parsedExpires = HttpDate.parse(expires);
        return parsedExpires;
      } catch (e) {
        // Jika parsing gagal, lanjutkan ke default
      }
    }
    return DateTime.now().add(const Duration(days: 1)); // Default valid till
  }

  /// Metode bantu untuk menentukan ekstensi file dari Content-Type
  String? _getExtensionFromContentType(String contentType) {
    switch (contentType) {
      case 'image/jpeg':
        return 'jpg';
      case 'image/png':
        return 'png';
      case 'image/gif':
        return 'gif';
      // Tambahkan lebih banyak mapping jika diperlukan
      default:
        return null;
    }
  }
}

class CustomHttpFileService extends HttpFileService {
  final Map<String, String> customHeaders;

  CustomHttpFileService({required this.customHeaders});

  @override
  Future<FileServiceResponse> get(String url,
      {Map<String, String>? headers}) async {
    // Gabungkan header tambahan dengan header bawaan (jika ada)
    final combinedHeaders = {...?headers, ...customHeaders};

    try {
      // Lakukan permintaan HTTP dengan header yang digabungkan
      final response = await http.get(Uri.parse(url), headers: combinedHeaders);

      if (response.statusCode == 200) {
        return CustomFileServiceResponse(
          body: response.bodyBytes,
          headers: response.headers,
          statusCode: response.statusCode,
        );
      } else {
        throw http.ClientException(
          'Failed to load $url with status code ${response.statusCode}',
          Uri.parse(url),
        );
      }
    } catch (e) {
      throw http.ClientException('Failed to load $url: $e', Uri.parse(url));
    }
  }
}

class CustomCacheManager {
  static const key = 'customCacheKey';

  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 20,
      repo: JsonCacheInfoRepository(databaseName: key),
      fileSystem: IOFileSystem(key),
      // Gunakan CustomHttpFileService dengan header Referer
      fileService: CustomHttpFileService(
        customHeaders: {
          'Referer': 'https://komikcast.cz/',
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36',
          'Accept':
              'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
          'Accept-Language': 'en-US,en;q=0.9',
        },
      ),
    ),
  );
}
