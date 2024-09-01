// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'komik_genre_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KomikGenreDetailModel _$KomikGenreDetailModelFromJson(
        Map<String, dynamic> json) =>
    KomikGenreDetailModel(
      current_page: (json['current_page'] as num).toInt(),
      length_page: (json['length_page'] as num).toInt(),
    );

Map<String, dynamic> _$KomikGenreDetailModelToJson(
        KomikGenreDetailModel instance) =>
    <String, dynamic>{
      'current_page': instance.current_page,
      'length_page': instance.length_page,
    };

KomikGenreDetailDataModel _$KomikGenreDetailDataModelFromJson(
        Map<String, dynamic> json) =>
    KomikGenreDetailDataModel(
      title: json['title'] as String,
      chapter: json['chapter'] as String,
      type: json['type'] as String,
      href: json['href'] as String,
      rating: json['rating'] as String,
      thumbnail: json['thumbnail'] as String,
    );

Map<String, dynamic> _$KomikGenreDetailDataModelToJson(
        KomikGenreDetailDataModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'chapter': instance.chapter,
      'type': instance.type,
      'href': instance.href,
      'rating': instance.rating,
      'thumbnail': instance.thumbnail,
    };
