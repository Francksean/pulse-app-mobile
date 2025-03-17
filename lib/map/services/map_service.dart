import 'dart:convert';
import 'dart:math';

import 'package:latlong2/latlong.dart';
import 'package:pulse_app_mobile/campaign/models/campaign_brief.dart';
import 'package:pulse_app_mobile/campaign/models/campaign_details.dart';
import 'package:pulse_app_mobile/common/dio/dio_client.dart';
import 'package:pulse_app_mobile/map/models/alert.dart';
import 'package:pulse_app_mobile/map/models/center_details.dart';
import 'package:pulse_app_mobile/map/models/center_position.dart';
import 'package:pulse_app_mobile/map/models/center_sub_details.dart';

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
      '/centers/within-square?minLat=$minLat&maxLat=$maxLat&minLng=$minLng&maxLng=$maxLng',
    );

    if (response.statusCode == 200) {
      List<dynamic> centerJson = response.data;
      return centerJson.map((json) => CenterPosition.fromJson(json)).toList();
    } else {
      throw Exception('Échec de la récupération des centres');
    }
  }

  Future<CenterDetails> fetchCenterDetails(String centerId) async {
    final centerDetailsFetched = await dioClient.dio.get(
      '/centers/$centerId',
    );

    CenterDetails centerDetails = CenterDetails();

    if (centerDetailsFetched.statusCode == 200) {
      print("OOOOOOOOOOOOOOOOOOOO");
      dynamic centerData = centerDetailsFetched.data;
      CenterSubDetails centerSubDetails = CenterSubDetails.fromJson(centerData);
      centerDetails.centerSubDetails = centerSubDetails;
      // fetch active campaign
      final activeCampaignFetched = await dioClient.dio.get(
        '/campaigns/center/$centerId/active',
      );
      if (activeCampaignFetched.statusCode == 200 &&
          activeCampaignFetched.data != "") {
        CampaignBrief activeCampaignData =
            CampaignBrief.fromJson(activeCampaignFetched.data);
        centerDetails.activeCampaign = activeCampaignData;
      }
      // fetch active alert
      final activeAlertFetched = await dioClient.dio.get(
        '/alerts/center/$centerId/active',
      );
      if (activeAlertFetched.statusCode == 200 &&
          activeAlertFetched.data != "") {
        Alert activeAlertData = Alert.fromJson(activeAlertFetched.data);
        centerDetails.activeAlert = activeAlertData;
      }
      print(centerDetails.toString());
      return centerDetails;
    } else {
      throw Exception('Échec de la récupération des centres');
    }
  }
}
