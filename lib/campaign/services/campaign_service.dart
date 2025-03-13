import 'package:pulse_app_mobile/campaign/models/campaign_details.dart';
import 'package:pulse_app_mobile/common/dio/dio_client.dart';

class CampaignService {
  final dioClient = DioClient.instance;

  Future<CampaignDetails> fetchCampaignById(String campaignId) async {
    final response = await dioClient.dio.get("/url-bla-bla-bla");

    if (response.statusCode == 200) {
      CampaignDetails campaignDetails = response.data;
      return campaignDetails;
    } else {
      throw Exception(
          "erreur lors de la récpération des détails de la campagne");
    }
  }
}
