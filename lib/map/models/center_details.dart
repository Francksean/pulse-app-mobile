import 'package:json_annotation/json_annotation.dart';
import 'package:pulse_app_mobile/map/models/alert.dart';
import 'package:pulse_app_mobile/campaign/models/campaign_brief.dart';

part 'center_details.g.dart';

@JsonSerializable()
class CenterDetails {
  final String? centerId;
  final String? centerName;
  final String? bannerUrl;
  final String? logoUrl;
  final bool? isOpen;
  final Alert? activeAlert;
  final CampaignBrief? activeCampaign;
  final String? phone;
  final String? address;

  CenterDetails({
    this.centerId,
    this.centerName,
    this.bannerUrl,
    this.logoUrl,
    this.isOpen,
    this.activeAlert,
    this.activeCampaign,
    this.phone,
    this.address,
  });

  factory CenterDetails.fromJson(Map<String, dynamic> json) =>
      _$CenterDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CenterDetailsToJson(this);

  CenterDetails copyWith({
    String? centerId,
    String? centerName,
    String? bannerUrl,
    String? logoUrl,
    bool? isOpen,
    Alert? activeAlert,
    CampaignBrief? activeCampaign,
    String? phone,
    String? address,
  }) {
    return CenterDetails(
        centerId: centerId ?? this.centerId,
        centerName: centerName ?? this.centerName,
        bannerUrl: bannerUrl ?? this.bannerUrl,
        logoUrl: logoUrl ?? this.logoUrl,
        isOpen: isOpen ?? this.isOpen,
        activeAlert: activeAlert ?? this.activeAlert,
        activeCampaign: activeCampaign ?? this.activeCampaign,
        phone: phone ?? this.phone,
        address: address ?? this.address);
  }
}
