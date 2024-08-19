import 'package:json_annotation/json_annotation.dart';
import 'package:floor/floor.dart';
import 'package:mangap/fetures/detail/domain/entities/komik_detail_entity.dart';

part 'komik_detail_model.g.dart';

@Entity(tableName: 'komik_detail', primaryKeys: ['href'])
@JsonSerializable()
class KomikDetailModel extends KomikDetailEntity {
  const KomikDetailModel({
    required super.href,
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

  Map<String, dynamic> toJson() => _$KomikDetailModelToJson(this);

  factory KomikDetailModel.fromEntity(KomikDetailEntity detail) {
    return KomikDetailModel(
      href: detail.href,
      title: detail.title,
      altTitle: detail.altTitle,
      updatedOn: detail.updatedOn,
      rating: detail.rating,
      status: detail.status,
      type: detail.type,
      released: detail.released,
      author: detail.author,
      description: detail.description,
      thumbnail: detail.thumbnail,
    );
  }
}

@JsonSerializable()
class GenreModel extends GenreEntity {
  const GenreModel({
    required super.title,
    required super.href,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) =>
      _$GenreModelFromJson(json);

  Map<String, dynamic> toJson() => _$GenreModelToJson(this);
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

  Map<String, dynamic> toJson() => _$ChapterModelToJson(this);
}
