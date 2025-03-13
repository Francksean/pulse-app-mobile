// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_brief.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignBrief _$CampaignBriefFromJson(Map<String, dynamic> json) =>
    CampaignBrief(
      campaignId: json['campaignId'] as String?,
      launchDate: json['launchDate'] == null
          ? null
          : DateTime.parse(json['launchDate'] as String),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      title: json['title'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$CampaignBriefToJson(CampaignBrief instance) =>
    <String, dynamic>{
      'campaignId': instance.campaignId,
      'launchDate': instance.launchDate?.toIso8601String(),
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'title': instance.title,
      'description': instance.description,
    };
