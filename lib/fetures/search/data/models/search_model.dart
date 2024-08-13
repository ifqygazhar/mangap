import 'package:json_annotation/json_annotation.dart';
import 'package:mangap/fetures/search/domain/entities/search_entity.dart';

part 'search_model.g.dart';

@JsonSerializable()
class SearchModel extends SearchEntity {
  const SearchModel({
    required super.title,
    required super.chapter,
    required super.type,
    required super.href,
    required super.rating,
    required super.thumbnail,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) =>
      _$SearchModelFromJson(json);
}
