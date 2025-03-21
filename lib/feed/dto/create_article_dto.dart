class CreateArticleDTO {
  final String title;
  final String content;
  final int authorId;

  CreateArticleDTO({
    required this.title,
    required this.content,
    required this.authorId,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'authorId': authorId,
    };
  }
}
