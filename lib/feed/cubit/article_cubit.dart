import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_app_mobile/feed/models/article.dart';
import 'package:pulse_app_mobile/feed/repository/feed_repository.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  final repository = FeedRepository();

  ArticleCubit() : super(ArticleInitial());

  Future<void> loadArticles() async {
    emit(ArticleLoading());
    try {
      final articles = await repository.fetchArticles(1, 10);
      emit(ArticleLoaded(articles: articles));
    } catch (e) {
      emit(ArticleError(e.toString()));
    }
  }

  Future<void> loadArticleDetails(String articleId) async {
    final currentState = state;
    if (currentState is ArticleLoaded) {
      emit(ArticleLoading());
      try {
        final article = await repository.getArticleById(articleId);
        final updatedArticles = currentState.articles
            .map((a) => a.id == articleId ? article : a)
            .toList();
        emit(ArticleLoaded(
          articles: updatedArticles,
          selectedArticle: article,
        ));
      } catch (e) {
        emit(ArticleError(e.toString()));
      }
    }
  }

  Future<void> likeArticle(String articleId, String reaction) async {
    final currentState = state;
    if (currentState is ArticleLoaded) {
      try {
        // Optimistic update
        final updatedArticles = currentState.articles.map((article) {
          if (article.id == articleId) {
            return article.copyWith(); // Add your like logic
          }
          return article;
        }).toList();

        emit(ArticleLoaded(
          articles: updatedArticles,
          selectedArticle: currentState.selectedArticle,
        ));

        await repository.likeArticle(articleId, reaction);
      } catch (e) {
        emit(ArticleError(e.toString()));
        emit(currentState);
      }
    }
  }

  Future<void> createArticle(Article article) async {
    emit(ArticleLoading());
    try {
      await repository.createArticle(article);
      await loadArticles();
    } catch (e) {
      emit(ArticleError(e.toString()));
    }
  }

  Future<void> updateArticle(Article article) async {
    final currentState = state;
    if (currentState is ArticleLoaded) {
      emit(ArticleLoading());
      try {
        final updatedArticle = await repository.updateArticle(article);
        final updatedArticles = currentState.articles
            .map((a) => a.id == article.id ? updatedArticle : a)
            .toList();
        emit(ArticleLoaded(
          articles: updatedArticles,
          selectedArticle: updatedArticle,
        ));
      } catch (e) {
        emit(ArticleError(e.toString()));
      }
    }
  }

  Future<void> deleteArticle(String articleId) async {
    final currentState = state;
    if (currentState is ArticleLoaded) {
      emit(ArticleLoading());
      try {
        await repository.deleteArticle(articleId);
        final updatedArticles =
            currentState.articles.where((a) => a.id != articleId).toList();
        emit(ArticleLoaded(
          articles: updatedArticles,
          selectedArticle: currentState.selectedArticle?.id == articleId
              ? null
              : currentState.selectedArticle,
        ));
      } catch (e) {
        emit(ArticleError(e.toString()));
      }
    }
  }
}
