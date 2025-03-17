import 'package:json_annotation/json_annotation.dart';
import 'package:pulse_app_mobile/map/models/alert.dart';
import 'package:pulse_app_mobile/campaign/models/campaign_brief.dart';
import 'package:pulse_app_mobile/map/models/center_sub_details.dart';

part 'center_details.g.dart';

@JsonSerializable()
class CenterDetails {
  CenterSubDetails? centerSubDetails;
  Alert? activeAlert;
  CampaignBrief? activeCampaign;

  CenterDetails({
    this.centerSubDetails,
    this.activeAlert,
    this.activeCampaign,
  });

  factory CenterDetails.fromJson(Map<String, dynamic> json) =>
      _$CenterDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CenterDetailsToJson(this);

  CenterDetails copyWith({
    CenterSubDetails? centerSubDetails,
    Alert? activeAlert,
    CampaignBrief? activeCampaign,
  }) {
    return CenterDetails(
      centerSubDetails: centerSubDetails ?? this.centerSubDetails,
      activeAlert: activeAlert ?? this.activeAlert,
      activeCampaign: activeCampaign ?? this.activeCampaign,
    );
  }
}
