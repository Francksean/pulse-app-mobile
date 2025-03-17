// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      id: json['id'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      postedOn: json['postedOn'] == null
          ? null
          : DateTime.parse(json['postedOn'] as String),
      coverUrl: json['coverUrl'] as String?,
      author: json['author'] == null
          ? null
          : Author.fromJson(json['author'] as Map<String, dynamic>),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'title': instance.title,
      'content': instance.content,
      'postedOn': instance.postedOn?.toIso8601String(),
      'coverUrl': instance.coverUrl,
      'images': instance.images,
    };
