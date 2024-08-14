import 'package:json_annotation/json_annotation.dart';
import 'package:mangap/fetures/read/domain/entities/read_entity.dart';

part 'read_model.g.dart';

@JsonSerializable()
class ReadModel extends ReadEntity {
  const ReadModel({
    required super.title,
    required super.prev,
    required super.next,
    required super.panel,
  });

  factory ReadModel.fromJson(Map<String, dynamic> json) =>
      _$ReadModelFromJson(json);
}
