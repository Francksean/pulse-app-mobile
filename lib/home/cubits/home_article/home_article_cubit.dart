import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_app_mobile/home/cubits/home_article/home_article_state.dart';

class HomeArticleCubit extends Cubit<HomeArticleState> {
  HomeArticleCubit() : super(InitialHomeArticleState());

  Future<void> fetchArticles() async {
    emit(LoadingState());
    try {
      emit(const HomeArticleLoadedState(articles: []));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }
}
