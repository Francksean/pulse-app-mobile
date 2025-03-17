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
      final CampaignDetails campaignDetails =
          await campaignService.fetchCampaignById(campaignId);
      emit(CampaignDetailsLoadedState(campaignDetails: campaignDetails));
    } catch (e) {
      emit(CampaignDetailsErrorState(error: e.toString()));
    }
  }
}
