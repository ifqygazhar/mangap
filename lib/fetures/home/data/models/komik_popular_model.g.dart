// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'komik_popular_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KomikPopularModel _$KomikPopularModelFromJson(Map<String, dynamic> json) =>
    KomikPopularModel(
      title: json['title'] as String,
      href: json['href'] as String,
      genre: json['genre'] as String,
      year: json['year'] as String,
      thumbnail: json['thumbnail'] as String,
    );

Map<String, dynamic> _$KomikPopularModelToJson(KomikPopularModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'href': instance.href,
      'genre': instance.genre,
      'year': instance.year,
      'thumbnail': instance.thumbnail,
    };
