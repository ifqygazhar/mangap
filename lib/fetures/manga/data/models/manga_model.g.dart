// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MangaModel _$MangaModelFromJson(Map<String, dynamic> json) => MangaModel(
      title: json['title'] as String,
      chapter: json['chapter'] as String,
      type: json['type'] as String,
      href: json['href'] as String,
      rating: json['rating'] as String,
      thumbnail: json['thumbnail'] as String,
    );

Map<String, dynamic> _$MangaModelToJson(MangaModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'chapter': instance.chapter,
      'type': instance.type,
      'href': instance.href,
      'rating': instance.rating,
      'thumbnail': instance.thumbnail,
    };
