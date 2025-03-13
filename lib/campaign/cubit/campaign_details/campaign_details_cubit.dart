import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pulse_app_mobile/campaign/models/campaign_details.dart';
import 'package:pulse_app_mobile/campaign/services/campaign_service.dart';
import 'package:pulse_app_mobile/map/models/center_details.dart';

part 'campaign_details_state.dart';

class CampaignDetailsCubit extends Cubit<CampaignDetailsState> {
  CampaignService campaignService = CampaignService();
  CampaignDetailsCubit() : super(CampaignDetailsInitial());

  Future<void> fetchCampaignDetails(String campaignId) async {
    emit(CampaignDetailsLoadingState());
    try {
      // final CampaignDetails campaignDetails =
      //     await campaignService.fetchCampaignById(campaignId);
      Future.delayed(const Duration(milliseconds: 500));
      emit(CampaignDetailsLoadedState(
          campaignDetails: CampaignDetails(
        center: CenterDetails(
          centerId: "",
          phone: "+237 675 32 18 36",
          address: "nyalla logbaba",
          centerName: 'Centre Principal',
          bannerUrl: 'https://example.com/banner.jpg',
          logoUrl: 'https://example.com/logo.png',
        ),
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 30)),
        title: 'Campagne de don de sang',
        description: 'Participez à notre campagne de don de sang !',
      )));
    } catch (e) {
      emit(CampaignDetailsErrorState(error: e.toString()));
    }
  }
}
