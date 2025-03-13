import 'package:json_annotation/json_annotation.dart';

part 'campaign_brief.g.dart';

@JsonSerializable()
class CampaignBrief {
  final String? campaignId;
  final DateTime? launchDate;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? title;
  final String? description;

  CampaignBrief({
    this.campaignId,
    this.launchDate,
    this.startDate,
    this.endDate,
    this.title,
    this.description,
  });

  factory CampaignBrief.fromJson(Map<String, dynamic> json) =>
      _$CampaignBriefFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignBriefToJson(this);

  CampaignBrief copyWith({
    String? campaignId,
    DateTime? launchDate,
    DateTime? startDate,
    DateTime? endDate,
    String? title,
    String? description,
  }) {
    return CampaignBrief(
      campaignId: campaignId ?? this.campaignId,
      launchDate: launchDate ?? this.launchDate,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}
