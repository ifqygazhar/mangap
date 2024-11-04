import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> downloadImage(String url) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Referer': 'https://komikcast.cz/',
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36',
      'Accept':
          'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
      'Accept-Language': 'en-US,en;q=0.9'
    },
  );

  if (response.statusCode == 200) {
    return response.bodyBytes; // Kembalikan byte data dari gambar
  } else {
    throw Exception('Failed to download image');
  }
}

Future<void> createPdfFromImages(List<String> imageUrls, String chapter) async {
  final pdf = pw.Document();

  for (String url in imageUrls) {
    try {
      final imageBytes = await downloadImage(url);
      final image = pw.MemoryImage(imageBytes);

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(image),
            );
          },
        ),
      );
    } catch (e) {
      log('Error processing image from $url: $e');
    }
  }

  final directory = await getApplicationDocumentsDirectory();
  final file = File(directory.path);

  await file.writeAsBytes(await pdf.save());
  log('PDF saved at: ${file.path}');
}
