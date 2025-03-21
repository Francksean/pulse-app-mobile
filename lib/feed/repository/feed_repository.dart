import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pulse_app_mobile/common/dio/dio_client.dart';
import 'package:pulse_app_mobile/common/models/paged_response.dart';
import 'package:pulse_app_mobile/feed/dto/create_article_dto.dart';
import 'package:pulse_app_mobile/feed/models/article.dart';

class FeedRepository {
  final dioClient = DioClient.instance;

  Future<PagedResponse<Article>> fetchArticles(int page, int size) async {
    try {
      final response = await dioClient.dio.get(
        "/articles/all",
        queryParameters: {
          'page': page,
          'size': size,
        },
      );

      if (response.statusCode == 200) {
        // Convertir la réponse JSON en PagedResponse<Article>
        return PagedResponse<Article>.fromJson(
          response.data,
          (json) => Article.fromJson(json),
        );
      }
      throw Exception('Failed to load articles: ${response.statusCode}');
    } catch (e) {
      throw Exception('Failed to load articles: $e');
    }
  }

  Future<Article> createArticle(
      CreateArticleDTO article, List<File> images) async {
    try {
      List<MultipartFile> imageFiles = [];
      for (var imageFile in images) {
        MultipartFile multipartFile = await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last, // Nom du fichier
        );
        imageFiles.add(multipartFile);
      }

      var formData = FormData.fromMap({
        "newArticleDatas": MultipartFile.fromString(
          jsonEncode(article),
          contentType: DioMediaType('application', 'json'),
        ),
        "images": imageFiles,
      });

      // Envoyer la requête POST
      final response = await dioClient.dio.post(
        "/articles/create",
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          headers: {
            'Accept': 'application/json',
          },
        ),
      );

      // Vérifier le statut de la réponse
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Article.fromJson(response.data);
      } else {
        throw Exception('Failed to create article: ${response.statusCode}');
      }
    } catch (e) {
      print('Error details: $e');
      throw Exception('Failed to create article: $e');
    }
  }
}
