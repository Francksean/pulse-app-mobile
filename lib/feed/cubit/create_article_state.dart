part of 'create_article_cubit.dart';

// States
abstract class CreateArticleState extends Equatable {
  const CreateArticleState();

  @override
  List<Object> get props => [];
}

class CreateArticleInitial extends CreateArticleState {}

class CreateArticleLoading extends CreateArticleState {}

class CreateArticleSuccess extends CreateArticleState {
  final dynamic article;

  const CreateArticleSuccess(this.article);

  @override
  List<Object> get props => [article];
}

class CreateArticleError extends CreateArticleState {
  final String message;

  const CreateArticleError(this.message);

  @override
  List<Object> get props => [message];
}
