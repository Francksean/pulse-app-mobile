part of 'article_cubit.dart';

sealed class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object> get props => [];
}

class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState {}

class ArticleLoaded extends ArticleState {
  final List<Article> articles;
  final Article? selectedArticle;

  const ArticleLoaded({
    required this.articles,
    this.selectedArticle,
  });

  @override
  List<Object> get props =>
      [articles, if (selectedArticle != null) selectedArticle!];

  ArticleLoaded copyWith({
    List<Article>? articles,
    Article? selectedArticle,
  }) {
    return ArticleLoaded(
      articles: articles ?? this.articles,
      selectedArticle: selectedArticle ?? this.selectedArticle,
    );
  }
}

class ArticleError extends ArticleState {
  final String message;

  const ArticleError(this.message);

  @override
  List<Object> get props => [message];
}
