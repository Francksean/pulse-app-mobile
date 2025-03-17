import 'package:dio/dio.dart';
import 'package:pulse_app_mobile/common/dio/dio_client.dart';
import 'package:pulse_app_mobile/feed/models/article.dart';

class HomeService {
  final dioClient = DioClient.instance;

  Future<List<Article>> fetchHomeArticle() async {
    try {
      final response = await dioClient.dio.get('/articles');

      if (response.statusCode == 200) {
        final List<dynamic> data =
            response.data; // Supposons que la réponse est une liste
        return data.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception(
            "Erreur lors de la récupération des articles : ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(
          "Erreur lors de la récupération des articles : ${e.toString()}");
    }
  }
}
