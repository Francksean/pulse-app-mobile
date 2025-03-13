import 'package:equatable/equatable.dart';
import 'package:pulse_app_mobile/feed/models/article.dart';

abstract class HomeArticleState extends Equatable {
  const HomeArticleState();
  @override
  List<Object?> get props => [];
}

class InitialHomeArticleState extends HomeArticleState {}

class LoadingState extends HomeArticleState {}

class ErrorState extends HomeArticleState {
  final String message;
  const ErrorState({required this.message});
}

class HomeArticleLoadedState extends HomeArticleState {
  final List<Article> articles;
  const HomeArticleLoadedState({required this.articles});
}
