import 'package:json_annotation/json_annotation.dart';
import 'package:mangap/fetures/home/domain/entities/komik_genre.dart';

part 'komik_genre_model.g.dart';

@JsonSerializable()
class KomikGenreModel extends KomikGenreEntity {
  const KomikGenreModel({
    required super.title,
    required super.href,
  });

  factory KomikGenreModel.fromJson(Map<String, dynamic> json) =>
      _$KomikGenreModelFromJson(json);
}
