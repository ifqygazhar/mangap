import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Url {
  static const String _mainUrlKey = 'mainUrl';
  static const String _backupUrlKey = 'backupUrl';

  // Simpan URL ke SharedPreferences
  static Future<void> saveUrls(String mainUrl, String backupUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_mainUrlKey, mainUrl);
    await prefs.setString(_backupUrlKey, backupUrl);
  }

  // Ambil URL utama dari SharedPreferences
  static Future<String?> getMainUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_mainUrlKey);
  }

  // Ambil URL cadangan dari SharedPreferences
  static Future<String?> getBackupUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_backupUrlKey);
  }
}

Future<void> fetchAndSaveUrls() async {
  try {
    // Ambil file konfigurasi dari URL
    final response =
        await http.get(Uri.parse('https://verifwebsite.github.io/config.txt'));

    if (response.statusCode == 200) {
      // Ambil isi file .txt sebagai string
      String content = response.body;

      // Pisahkan file berdasarkan baris
      List<String> lines = content.split('\n');

      // Variabel untuk menyimpan nilai URL
      String? mainUrl;
      String? backupUrl;

      // Loop untuk memproses setiap baris
      for (String line in lines) {
        // Hilangkan spasi dan newline yang tidak perlu
        line = line.trim();

        if (line.isNotEmpty) {
          // Pisahkan key dan value berdasarkan '='
          List<String> parts = line.split('=');
          if (parts.length == 2) {
            String key = parts[0].trim();
            String value = parts[1].trim();

            // Simpan berdasarkan key
            if (key == 'main') {
              mainUrl = value;
            } else if (key == 'backup') {
              backupUrl = value;
            }
          }
        }
      }

      // Periksa apakah URL sudah sesuai dengan yang ada di SharedPreferences
      final sharedPreferences = await SharedPreferences.getInstance();
      String? savedMainUrl = sharedPreferences.getString('mainUrl');
      String? savedBackupUrl = sharedPreferences.getString('backupUrl');

      // Jika data belum ada atau URL berbeda, simpan URL baru
      if (mainUrl != null && backupUrl != null) {
        if (savedMainUrl == null ||
            savedBackupUrl == null ||
            savedMainUrl != mainUrl ||
            savedBackupUrl != backupUrl) {
          // Simpan URL baru ke SharedPreferences
          await sharedPreferences.setString('mainUrl', mainUrl);
          await sharedPreferences.setString('backupUrl', backupUrl);
        }
      } else {
        print('Failed to extract URLs from text file.');
      }
    } else {
      print('Failed to load config file.');
    }
  } catch (e) {
    print('Error: $e');
  }
}
