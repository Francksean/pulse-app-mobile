import 'package:pulse_app_mobile/campaign/models/campaign_details.dart';
import 'package:pulse_app_mobile/common/dio/dio_client.dart';

class CampaignService {
  final dioClient = DioClient.instance;

  Future<CampaignDetails> fetchCampaignById(String campaignId) async {
    final response = await dioClient.dio.get("/campaigns/$campaignId");

    if (response.statusCode == 200) {
      dynamic datas = response.data;
      print(datas);
      CampaignDetails campaignDetails = CampaignDetails.fromJson(datas);
      return campaignDetails;
    } else {
      throw Exception(
          "erreur lors de la récpération des détails de la campagne");
    }
  }
}
