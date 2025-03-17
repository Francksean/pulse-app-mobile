import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  final String? id;
  final String? articleId;
  final String? authorName;
  final String? authorAvatarUrl;
  final String? content;
  final DateTime? createdAt;
  final bool? isLiked;
  final int? likeCount;
  final List<Comment>? replies;

  Comment({
    this.id,
    this.articleId,
    this.authorName,
    this.authorAvatarUrl,
    this.content,
    this.createdAt,
    this.isLiked = false,
    this.likeCount = 0,
    this.replies,
  });

  Comment copyWith({
    String? id,
    String? articleId,
    String? authorName,
    String? authorAvatarUrl,
    String? content,
    DateTime? createdAt,
    bool? isLiked,
    int? likeCount,
    List<Comment>? replies,
  }) {
    return Comment(
      id: id ?? this.id,
      articleId: articleId ?? this.articleId,
      authorName: authorName ?? this.authorName,
      authorAvatarUrl: authorAvatarUrl ?? this.authorAvatarUrl,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      isLiked: isLiked ?? this.isLiked,
      likeCount: likeCount ?? this.likeCount,
      replies: replies ?? this.replies,
    );
  }

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
