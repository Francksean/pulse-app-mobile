import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
class Article {
  final String? id;
  final String? title;
  final String? content;
  final DateTime? postedOn;
  final String? coverUrl;
  final List<String>? images;

  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.postedOn,
    required this.coverUrl,
    this.images,
  });

  Article copyWith(
      {String? id,
      String? title,
      String? content,
      DateTime? postedOn,
      String? coverUrl,
      List<String>? images}) {
    return Article(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        postedOn: postedOn ?? postedOn,
        coverUrl: coverUrl ?? this.coverUrl,
        images: images ?? this.images);
  }

  /// Factory method pour générer une instance de `Article` depuis un JSON.
  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  /// Méthode pour convertir une instance de `Article` en JSON.
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
