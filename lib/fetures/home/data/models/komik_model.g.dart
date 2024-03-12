// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'komik_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KomikModel _$KomikModelFromJson(Map<String, dynamic> json) => KomikModel(
      json['completed'] as bool?,
      coverImg: json['coverImg'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      latestChapter: json['latestChapter'] as String,
      rating: json['rating'] as String,
      slug: json['slug'] as String,
    );

Map<String, dynamic> _$KomikModelToJson(KomikModel instance) =>
    <String, dynamic>{
      'coverImg': instance.coverImg,
      'title': instance.title,
      'type': instance.type,
      'latestChapter': instance.latestChapter,
      'rating': instance.rating,
      'slug': instance.slug,
      'completed': instance.completed,
    };
