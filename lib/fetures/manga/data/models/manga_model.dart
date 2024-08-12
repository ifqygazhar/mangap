import 'package:json_annotation/json_annotation.dart';
import 'package:mangap/fetures/manga/domain/entities/manga_entity.dart';

part 'manga_model.g.dart';

@JsonSerializable()
class MangaModel extends MangaEntity {
  const MangaModel({
    required super.title,
    required super.chapter,
    required super.type,
    required super.href,
    required super.rating,
    required super.thumbnail,
  });

  factory MangaModel.fromJson(Map<String, dynamic> json) =>
      _$MangaModelFromJson(json);
}
