part of 'comment_cubit.dart';

abstract class CommentState {}

final class CommentInitial extends CommentState {}

final class CommentLoading extends CommentState {}

final class CommentLoaded extends CommentState {
  final List<Comment> comments;

  CommentLoaded({required this.comments});
}

final class CommentError extends CommentState {
  final String message;

  CommentError(this.message);
}
