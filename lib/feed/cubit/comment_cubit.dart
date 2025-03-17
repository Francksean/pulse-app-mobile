import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_app_mobile/feed/models/comment.dart';
import 'package:pulse_app_mobile/feed/repository/comment_repository.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  final repository = CommentRepository();

  CommentCubit() : super(CommentInitial());

  /// Charge les commentaires d'un article
  Future<void> loadComments(String articleId) async {
    emit(CommentLoading());
    try {
      final comments = await repository.fetchComments(articleId);
      emit(CommentLoaded(comments: comments));
    } catch (e) {
      emit(CommentError('Failed to load comments: $e'));
    }
  }

  /// Ajoute un nouveau commentaire
  Future<void> addComment(String articleId, Comment comment) async {
    final currentState = state;
    if (currentState is CommentLoaded) {
      try {
        final newComment = await repository.addComment(
          articleId,
          comment,
        );

        // Mise à jour de la liste des commentaires
        final updatedComments = [newComment, ...currentState.comments];
        emit(CommentLoaded(comments: updatedComments));
      } catch (e) {
        emit(CommentError('Failed to add comment: $e'));
      }
    }
  }

  /// Répondre à un commentaire
  Future<void> replyToComment(String parentCommentId, String content) async {
    final currentState = state;
    if (currentState is CommentLoaded) {
      try {
        final reply = await repository.replyToComment(
          parentCommentId: parentCommentId,
          content: content,
        );

        // Mise à jour de la liste des commentaires
        final updatedComments = currentState.comments.map((comment) {
          if (comment.id == parentCommentId) {
            return comment.copyWith(
              replies: [...(comment.replies ?? []), reply],
            );
          }
          return comment;
        }).toList();

        emit(CommentLoaded(comments: updatedComments));
      } catch (e) {
        emit(CommentError('Failed to reply to comment: $e'));
      }
    }
  }

  /// Aimer ou retirer l'appréciation d'un commentaire
  Future<void> toggleLikeComment(String commentId) async {
    final currentState = state;
    if (currentState is CommentLoaded) {
      try {
        // Mise à jour optimiste
        final updatedComments = currentState.comments.map((comment) {
          if (comment.id == commentId) {
            return comment.copyWith(
              isLiked: !(comment.isLiked ?? false),
              likeCount: (comment.isLiked ?? false)
                  ? (comment.likeCount ?? 0) - 1
                  : (comment.likeCount ?? 0) + 1,
            );
          }
          return comment;
        }).toList();

        emit(CommentLoaded(comments: updatedComments));

        // Envoyer la requête au serveur
        await repository.toggleLikeComment(commentId);
      } catch (e) {
        emit(CommentError('Failed to like comment: $e'));
        // Revenir à l'état précédent en cas d'erreur
        emit(currentState);
      }
    }
  }
}
