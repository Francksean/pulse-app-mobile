import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pulse_app_mobile/feed/dto/create_article_dto.dart';
import 'package:pulse_app_mobile/feed/repository/feed_repository.dart';

part 'create_article_state.dart';

// Cubit
class CreateArticleCubit extends Cubit<CreateArticleState> {
  final FeedRepository _articleRepository = FeedRepository();

  CreateArticleCubit() : super(CreateArticleInitial());

  Future<void> createArticle({
    required String title,
    required String content,
    required List<File> images,
    required int authorId,
  }) async {
    try {
      emit(CreateArticleLoading());

      final dto = CreateArticleDTO(
        title: title,
        content: content,
        authorId: authorId,
      );

      final result = await _articleRepository.createArticle(dto, images);
      emit(CreateArticleSuccess(result));
    } catch (e) {
      emit(CreateArticleError(e.toString()));
    }
  }
}
