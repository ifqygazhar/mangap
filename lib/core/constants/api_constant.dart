import 'package:secure_dotenv/secure_dotenv.dart';

part 'api_constant.g.dart';

@DotEnvGen(
  filename: '.env',
  fieldRename: FieldRename.screamingSnake,
)
abstract class ApiConstant {
  const factory ApiConstant() = _$ApiConstant;

  const ApiConstant._();

  String get baseUrl;
  String get komikRecomended;
  String get komikPopular;
  String get komikList;
  String get komikDetail;
  String get search;
  String get genre;
  String get genreDetail;
  String get allManga;
  String get read;

  String get backupUrl;
  String get backupKomikRecomended;
  String get backupKomikPopular;
  String get backupKomikList;
  String get backupKomikDetail;
  String get backupSearch;
  String get backupGenre;
  String get backupGenreDetail;
  String get backupAllManga;
  String get backupRead;
}
