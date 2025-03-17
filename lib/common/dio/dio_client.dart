import 'package:dio/dio.dart';

class DioClient {
  // Instance privée de Dio
  static final DioClient _instance = DioClient._internal();
  late Dio dio;

  // Constructeur privé
  DioClient._internal() {
    dio = Dio(BaseOptions(
      baseUrl: 'http://192.168.100.6:9000/api/v1',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print('Requête envoyée : ${options.uri}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('Réponse reçue : ${response.data}');
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
