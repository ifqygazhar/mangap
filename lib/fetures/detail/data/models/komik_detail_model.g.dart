// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'komik_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KomikDetailModel _$KomikDetailModelFromJson(Map<String, dynamic> json) =>
    KomikDetailModel(
      href: json['href'] as String?,
      title: json['title'] as String,
      altTitle: json['altTitle'] as String,
      updatedOn: json['updatedOn'] as String,
      rating: json['rating'] as String,
      status: json['status'] as String,
      type: json['type'] as String,
      released: json['released'] as String,
      author: json['author'] as String,
      description: json['description'] as String,
      thumbnail: json['thumbnail'] as String,
    );

Map<String, dynamic> _$KomikDetailModelToJson(KomikDetailModel instance) =>
    <String, dynamic>{
      'href': instance.href,
      'title': instance.title,
      'altTitle': instance.altTitle,
      'updatedOn': instance.updatedOn,
      'rating': instance.rating,
      'status': instance.status,
      'type': instance.type,
      'released': instance.released,
      'author': instance.author,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
    };

GenreModel _$GenreModelFromJson(Map<String, dynamic> json) => GenreModel(
      title: json['title'] as String,
      href: json['href'] as String,
    );

Map<String, dynamic> _$GenreModelToJson(GenreModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'href': instance.href,
    };

ChapterModel _$ChapterModelFromJson(Map<String, dynamic> json) => ChapterModel(
      title: json['title'] as String,
      href: json['href'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$ChapterModelToJson(ChapterModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'href': instance.href,
      'date': instance.date,
    };
