import 'dart:convert';
import 'dart:math';

import 'package:latlong2/latlong.dart';
import 'package:pulse_app_mobile/common/dio/dio_client.dart';
import 'package:pulse_app_mobile/map/models/center_position.dart';

class MapService {
  final dioClient = DioClient.instance;

  /// fonction pour récupérer l'ensemble des centres dans un rayon donné
  Future<List<CenterPosition>> fetchCentersInSquare(
      List<LatLng> corners) async {
// Trouver les valeurs min et max pour lat et lng
    double minLat = corners.map((c) => c.latitude).reduce(min);
    double maxLat = corners.map((c) => c.latitude).reduce(max);
    double minLng = corners.map((c) => c.longitude).reduce(min);
    double maxLng = corners.map((c) => c.longitude).reduce(max);

    final response = await dioClient.dio.get(
      '/centres/within-square?minLat=$minLat&maxLat=$maxLat&minLng=$minLng&maxLng=$maxLng',
    );

    if (response.statusCode == 200) {
      List<dynamic> centresJson = jsonDecode(response.data);
      return centresJson.map((json) => CenterPosition.fromJson(json)).toList();
    } else {
      throw Exception('Échec de la récupération des centres');
    }
  }
}
