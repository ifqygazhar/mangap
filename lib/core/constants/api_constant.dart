import 'package:mangap/core/local/pref/url.dart';

abstract class ApiConstant {
  // Menambahkan konstruktor kosong
  const ApiConstant._();

  static String? _baseUrl;
  static String? _komikRecomended;
  static String? _komikPopular;
  static String? _komikList;
  static String? _komikDetail;
  static String? _search;
  static String? _genre;
  static String? _genreDetail;
  static String? _allManga;
  static String? _read;

  static String? _backupUrl;
  static String? _backupKomikRecomended;
  static String? _backupKomikPopular;
  static String? _backupKomikList;
  static String? _backupKomikDetail;
  static String? _backupSearch;
  static String? _backupGenre;
  static String? _backupGenreDetail;
  static String? _backupAllManga;
  static String? _backupRead;

  // Metode untuk menginisialisasi baseUrl dan backupUrl secara asinkron
  static Future<void> initializeUrls() async {
    // Ambil baseUrl dan backupUrl secara asinkron
    _baseUrl = await Url.getMainUrl();
    _backupUrl = await Url.getBackupUrl();

    // Set API endpoints berdasarkan baseUrl dan backupUrl
    if (_baseUrl != null) {
      _komikRecomended = "$_baseUrl/recommended";
      _komikPopular = "$_baseUrl/popular";
      _komikList = "$_baseUrl/daftar-komik";
      _komikDetail = "$_baseUrl/detail";
      _search = "$_baseUrl/search?keyword=";
      _genre = "$_baseUrl/genre";
      _genreDetail = "$_baseUrl/genres";
      _allManga = "$_baseUrl/daftar-komik";
      _read = "$_baseUrl/read";
    }

    // Set backup endpoints jika backupUrl tersedia
    if (_backupUrl != null) {
      _backupKomikRecomended = "$_backupUrl/recommended";
      _backupKomikPopular = "$_backupUrl/popular";
      _backupKomikList = "$_backupUrl/daftar-komik";
      _backupKomikDetail = "$_backupUrl/detail";
      _backupSearch = "$_backupUrl/search?keyword=";
      _backupGenre = "$_backupUrl/genre";
      _backupGenreDetail = "$_backupUrl/genres";
      _backupAllManga = "$_backupUrl/daftar-komik";
      _backupRead = "$_backupUrl/read";
    }
  }

  // Getter untuk baseUrl dan API endpoints utama
  static String? get baseUrl => _baseUrl;
  static String? get komikRecomended => _komikRecomended;
  static String? get komikPopular => _komikPopular;
  static String? get komikList => _komikList;
  static String? get komikDetail => _komikDetail;
  static String? get search => _search;
  static String? get genre => _genre;
  static String? get genreDetail => _genreDetail;
  static String? get allManga => _allManga;
  static String? get read => _read;

  // Getter untuk backupUrl dan API endpoints cadangan
  static String? get backupUrl => _backupUrl;
  static String? get backupKomikRecomended => _backupKomikRecomended;
  static String? get backupKomikPopular => _backupKomikPopular;
  static String? get backupKomikList => _backupKomikList;
  static String? get backupKomikDetail => _backupKomikDetail;
  static String? get backupSearch => _backupSearch;
  static String? get backupGenre => _backupGenre;
  static String? get backupGenreDetail => _backupGenreDetail;
  static String? get backupAllManga => _backupAllManga;
  static String? get backupRead => _backupRead;
}
