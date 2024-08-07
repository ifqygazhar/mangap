import 'package:mangap/fetures/home/domain/entities/komik_recommended_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'komik_recommended_model.g.dart';

@JsonSerializable()
class KomikRecommendedModel extends KomikRecommendedEntity {
  const KomikRecommendedModel({
    required super.title,
    required super.href,
    required super.rating,
    required super.thumbnail,
    required super.chapter,
    required super.type,
  });

  factory KomikRecommendedModel.fromJson(Map<String, dynamic> json) =>
      _$KomikRecommendedModelFromJson(json);
}
