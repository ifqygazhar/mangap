import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:floor/floor.dart';
import 'package:mangap/fetures/read/domain/entities/read_entity.dart';

part 'read_model.g.dart';

@Entity(tableName: 'chapter', primaryKeys: ['title'])
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

  factory ReadModel.fromEntity(ReadEntity read) {
    return ReadModel(
      title: read.title,
      prev: read.prev,
      next: read.next,
      panel: read.panel,
    );
  }

  Map<String, dynamic> toJson() => _$ReadModelToJson(this);
}

class PanelTypeConverter extends TypeConverter<List<dynamic>, String> {
  @override
  List<dynamic> decode(String databaseValue) {
    return jsonDecode(databaseValue);
  }

  @override
  String encode(List<dynamic> value) {
    return jsonEncode(value);
  }
}
