// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignDetails _$CampaignDetailsFromJson(Map<String, dynamic> json) =>
    CampaignDetails(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      banner: json['banner'] as String?,
      center: json['center'] == null
          ? null
          : CenterDetails.fromJson(json['center'] as Map<String, dynamic>),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      status: $enumDecodeNullable(_$CampaignStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$CampaignDetailsToJson(CampaignDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'banner': instance.banner,
      'center': instance.center,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'status': _$CampaignStatusEnumMap[instance.status],
    };

const _$CampaignStatusEnumMap = {
  CampaignStatus.upcoming: 'upcoming',
  CampaignStatus.active: 'active',
  CampaignStatus.completed: 'completed',
  CampaignStatus.cancelled: 'cancelled',
};
