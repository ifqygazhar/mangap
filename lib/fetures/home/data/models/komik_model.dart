import 'package:mangap/fetures/home/domain/entities/komik_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'komik_model.g.dart';

@JsonSerializable()
class KomikModel extends KomikEntity {
  const KomikModel(
    super.completed, {
    required super.coverImg,
    required super.title,
    required super.type,
    required super.latestChapter,
    required super.rating,
    required super.slug,
  });

  factory KomikModel.fromJson(Map<String, dynamic> json) =>
      _$KomikModelFromJson(json);
}
