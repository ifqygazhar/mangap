import 'package:json_annotation/json_annotation.dart';
import 'package:mangap/fetures/home/domain/entities/komik_popular_entity.dart';

part 'komik_popular_model.g.dart';

@JsonSerializable()
class KomikPopularModel extends KomikPopularEntity {
  const KomikPopularModel({
    required super.title,
    required super.href,
    required super.genre,
    required super.year,
    required super.thumbnail,
  });

  factory KomikPopularModel.fromJson(Map<String, dynamic> json) =>
      _$KomikPopularModelFromJson(json);
}
