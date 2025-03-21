part of 'article_cubit.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object?> get props => [];
}

class ArticleInitialState extends ArticleState {}

class ArticleLoadingState extends ArticleState {}

class ArticleLoadedState extends ArticleState {
  final List<Article> articles;
  final bool hasMore;
  const ArticleLoadedState({required this.articles, required this.hasMore});

  @override
  List<Object?> get props => [articles, hasMore];
}

class ArticleErrorState extends ArticleState {
  final String errorMessage;
  const ArticleErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
