import 'package:json_annotation/json_annotation.dart';
import 'package:mangap/fetures/detail/domain/entities/komik_detail_entity.dart';

part 'komik_detail_model.g.dart';

@JsonSerializable()
class KomikDetailModel extends KomikDetailEntity {
  const KomikDetailModel({
    required super.title,
    required super.altTitle,
    required super.updatedOn,
    required super.rating,
    required super.status,
    required super.type,
    required super.released,
    required super.author,
    required super.description,
    required super.thumbnail,
  });

  factory KomikDetailModel.fromJson(Map<String, dynamic> json) =>
      _$KomikDetailModelFromJson(json);
}

@JsonSerializable()
class GenreModel extends GenreEntity {
  const GenreModel({
    required super.title,
    required super.href,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) =>
      _$GenreModelFromJson(json);
}

@JsonSerializable()
class ChapterModel extends ChapterEntity {
  const ChapterModel({
    required super.title,
    required super.href,
    required super.date,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) =>
      _$ChapterModelFromJson(json);
}
