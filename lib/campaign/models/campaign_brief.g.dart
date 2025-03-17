// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_brief.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignBrief _$CampaignBriefFromJson(Map<String, dynamic> json) =>
    CampaignBrief(
      id: (json['id'] as num?)?.toInt(),
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
      'id': instance.id,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'title': instance.title,
      'description': instance.description,
    };
