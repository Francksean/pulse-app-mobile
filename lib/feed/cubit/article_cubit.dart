import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_app_mobile/common/models/paged_response.dart';
import 'package:pulse_app_mobile/feed/models/article.dart';
import 'package:pulse_app_mobile/feed/repository/feed_repository.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  final FeedRepository repository = FeedRepository();
  int _currentPage = 0;
  final List<Article> _articles = [];
  bool _isLoading = false;

  ArticleCubit() : super(ArticleInitialState());

  Future<void> loadArticles({bool loadMore = false}) async {
    if (_isLoading) return;
    _isLoading = true;

    if (!loadMore) {
      _currentPage = 0;
      _articles.clear();
      emit(ArticleLoadingState());
    }

    try {
      final PagedResponse<Article> pagedResponse =
          await repository.fetchArticles(_currentPage, 10);
      _articles.addAll(pagedResponse.content);
      emit(ArticleLoadedState(
        articles: List.of(_articles),
        hasMore: !pagedResponse.last,
      ));
      _currentPage++;
    } catch (e) {
      emit(ArticleErrorState(e.toString()));
    } finally {
      _isLoading = false;
    }
  }
}
