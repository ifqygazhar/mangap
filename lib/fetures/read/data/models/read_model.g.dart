// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'read_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadModel _$ReadModelFromJson(Map<String, dynamic> json) => ReadModel(
      title: json['title'] as String,
      prev: json['prev'] as String?,
      next: json['next'] as String?,
      panel: json['panel'] as List<dynamic>,
    );

Map<String, dynamic> _$ReadModelToJson(ReadModel instance) => <String, dynamic>{
      'title': instance.title,
      'prev': instance.prev,
      'next': instance.next,
      'panel': instance.panel,
    };
