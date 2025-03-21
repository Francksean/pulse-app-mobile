import 'package:json_annotation/json_annotation.dart';
import 'package:pulse_app_mobile/feed/models/author.dart';

part 'article.g.dart';

@JsonSerializable()
class Article {
  final int? id;
  final Author? author;
  final String? title;
  final String? slug;
  final String? content;
  final DateTime? publishedDate;
  final List<String>? images;

  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.publishedDate,
    required this.slug,
    this.author,
    this.images,
  });

  Article copyWith(
      {int? id,
      String? title,
      String? content,
      String? slug,
      Author? author,
      DateTime? publishedDate,
      List<String>? images}) {
    return Article(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        slug: slug ?? this.slug,
        publishedDate: publishedDate ?? publishedDate,
        author: author ?? this.author,
        images: images ?? this.images);
  }

  /// Factory method pour générer une instance de `Article` depuis un JSON.
  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  /// Méthode pour convertir une instance de `Article` en JSON.
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
