part of 'campaign_details_cubit.dart';

sealed class CampaignDetailsState extends Equatable {
  const CampaignDetailsState();

  @override
  List<Object> get props => [];
}

final class CampaignDetailsInitial extends CampaignDetailsState {}

final class CampaignDetailsErrorState extends CampaignDetailsState {
  final String error;
  const CampaignDetailsErrorState({required this.error});
}

final class CampaignDetailsLoadingState extends CampaignDetailsState {}

final class CampaignDetailsLoadedState extends CampaignDetailsState {
  final CampaignDetails campaignDetails;
  const CampaignDetailsLoadedState({required this.campaignDetails});
}
