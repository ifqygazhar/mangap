// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'komik_recommended_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KomikRecommendedModel _$KomikRecommendedModelFromJson(
        Map<String, dynamic> json) =>
    KomikRecommendedModel(
      title: json['title'] as String,
      href: json['href'] as String,
      rating: json['rating'] as String,
      thumbnail: json['thumbnail'] as String,
      chapter: json['chapter'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$KomikRecommendedModelToJson(
        KomikRecommendedModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'href': instance.href,
      'rating': instance.rating,
      'thumbnail': instance.thumbnail,
      'chapter': instance.chapter,
      'type': instance.type,
    };
