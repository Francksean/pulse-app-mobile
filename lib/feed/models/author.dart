import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';

@JsonSerializable()
class Author {
  final String? id;
  final String? username;

  Author({this.id, this.username});

  Author copyWith({String? id, String? username}) {
    return Author(
      id: id ?? this.id,
      username: username ?? this.username,
    );
  }

  /// Factory method pour générer une instance de `Article` depuis un JSON.
  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  /// Méthode pour convertir une instance de `Author` en JSON.
  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}
