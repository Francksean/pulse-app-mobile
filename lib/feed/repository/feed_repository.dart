import 'package:pulse_app_mobile/common/dio/dio_client.dart';
import 'package:pulse_app_mobile/feed/models/article.dart';

class FeedRepository {
  final dioClient = DioClient.instance;

  FeedRepository();

  Future<List<Article>> fetchArticles(int page, int size) async {
    try {
      final response = await dioClient.dio.get("/articles", queryParameters: {
        'page': page,
        'size': size,
      });

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => Article.fromJson(json))
            .toList();
      }
      throw Exception('Failed to load articles: ${response.statusCode}');
    } catch (e) {
      throw Exception('Failed to load articles: $e');
    }
  }

  Future<Article> getArticleById(String articleId) async {
    try {
      final response = await dioClient.dio.get("/articles/$articleId");
      if (response.statusCode == 200) {
        return Article.fromJson(response.data);
      }
      throw Exception('Failed to load article: ${response.statusCode}');
    } catch (e) {
      throw Exception('Failed to load article: $e');
    }
  }

  Future<void> likeArticle(String articleId, String reaction) async {
    try {
      await dioClient.dio.post(
        "/articles/$articleId/like",
        data: {'reaction': reaction},
      );
    } catch (e) {
      throw Exception('Failed to like article: $e');
    }
  }

  Future<Article> createArticle(Article article) async {
    try {
      final response = await dioClient.dio.post(
        "/articles",
        data: article.toJson(),
      );
      if (response.statusCode == 201) {
        return Article.fromJson(response.data);
      }
      throw Exception('Failed to create article: ${response.statusCode}');
    } catch (e) {
      throw Exception('Failed to create article: $e');
    }
  }

  Future<Article> updateArticle(Article article) async {
    try {
      final response = await dioClient.dio.put(
        "/articles/${article.id}",
        data: article.toJson(),
      );
      if (response.statusCode == 200) {
        return Article.fromJson(response.data);
      }
      throw Exception('Failed to update article: ${response.statusCode}');
    } catch (e) {
      throw Exception('Failed to update article: $e');
    }
  }

  Future<void> deleteArticle(String articleId) async {
    try {
      await dioClient.dio.delete("/articles/$articleId");
    } catch (e) {
      throw Exception('Failed to delete article: $e');
    }
  }
}
