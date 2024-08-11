import 'package:json_annotation/json_annotation.dart';
import 'package:mangap/fetures/genre/domain/entities/genre_detail_entity.dart';

part 'komik_genre_detail_model.g.dart';

@JsonSerializable()
class KomikGenreDetailModel extends KomikGenreDetailEntity {
  const KomikGenreDetailModel({
    required super.current_page,
    required super.length_page,
  });

  factory KomikGenreDetailModel.fromJson(Map<String, dynamic> json) {
    return KomikGenreDetailModel(
      current_page: json['current_page'] as int,
      length_page: json['length_page'] as int,
    );
  }
}

@JsonSerializable()
class KomikGenreDetailDataModel extends KomikGenreDetailDataEntity {
  const KomikGenreDetailDataModel({
    required super.title,
    required super.chapter,
    required super.type,
    required super.href,
    required super.rating,
    required super.thumbnail,
  });

  factory KomikGenreDetailDataModel.fromJson(Map<String, dynamic> json) =>
      _$KomikGenreDetailDataModelFromJson(json);
}
