import 'package:pulse_app_mobile/common/dio/dio_client.dart';
import 'package:pulse_app_mobile/feed/models/comment.dart';

class CommentRepository {
  final dioClient = DioClient.instance;

  CommentRepository();

  /// Récupère les commentaires d'un article
  Future<List<Comment>> fetchComments(String articleId) async {
    try {
      final response = await dioClient.dio.get('/articles/$articleId/comments');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => Comment.fromJson(json))
            .toList();
      }
      throw Exception('Failed to load comments: ${response.statusCode}');
    } catch (e) {
      throw Exception('Failed to load comments: $e');
    }
  }

  /// Ajoute un nouveau commentaire
  Future<Comment> addComment(String articleId, Comment comment) async {
    try {
      final response = await dioClient.dio.post(
        '/articles/$articleId/comments',
        data: comment.toJson(),
      );
      if (response.statusCode == 201) {
        return Comment.fromJson(response.data);
      }
      throw Exception('Failed to add comment: ${response.statusCode}');
    } catch (e) {
      throw Exception('Failed to add comment: $e');
    }
  }

  /// Répondre à un commentaire
  Future<Comment> replyToComment({
    required String parentCommentId,
    required String content,
  }) async {
    try {
      final response = await dioClient.dio.post(
        '/comments/$parentCommentId/replies',
        data: {'content': content},
      );
      if (response.statusCode == 201) {
        return Comment.fromJson(response.data);
      }
      throw Exception('Failed to reply to comment: ${response.statusCode}');
    } catch (e) {
      throw Exception('Failed to reply to comment: $e');
    }
  }

  /// Aimer ou retirer l'appréciation d'un commentaire
  Future<void> toggleLikeComment(String commentId) async {
    try {
      await dioClient.dio.post('/comments/$commentId/like');
    } catch (e) {
      throw Exception('Failed to like comment: $e');
    }
  }
}
