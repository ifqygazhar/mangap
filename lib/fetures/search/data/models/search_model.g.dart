// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchModel _$SearchModelFromJson(Map<String, dynamic> json) => SearchModel(
      title: json['title'] as String,
      chapter: json['chapter'] as String,
      type: json['type'] as String,
      href: json['href'] as String,
      rating: json['rating'] as String,
      thumbnail: json['thumbnail'] as String,
    );

Map<String, dynamic> _$SearchModelToJson(SearchModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'chapter': instance.chapter,
      'type': instance.type,
      'href': instance.href,
      'rating': instance.rating,
      'thumbnail': instance.thumbnail,
    };
