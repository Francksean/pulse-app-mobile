import 'package:dio/dio.dart';

class DioClient {
  // Instance privée de Dio
  static final DioClient _instance = DioClient._internal();
  late Dio dio;

  // Constructeur privé
  DioClient._internal() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://api.example.com', // URL de base
      connectTimeout: const Duration(seconds: 5), // Timeout de connexion
      receiveTimeout: const Duration(seconds: 3), // Timeout de réception
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print('Requête envoyée : ${options.uri}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('Réponse reçue : ${response.statusCode}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        print('Erreur : ${e.message}');
        return handler.next(e);
      },
    ));
  }

  // Getter pour accéder à l'instance unique
  static DioClient get instance => _instance;
}
