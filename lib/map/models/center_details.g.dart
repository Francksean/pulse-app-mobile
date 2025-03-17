// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'center_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CenterDetails _$CenterDetailsFromJson(Map<String, dynamic> json) =>
    CenterDetails(
      centerSubDetails: json['centerSubDetails'] == null
          ? null
          : CenterSubDetails.fromJson(
              json['centerSubDetails'] as Map<String, dynamic>),
      activeAlert: json['activeAlert'] == null
          ? null
          : Alert.fromJson(json['activeAlert'] as Map<String, dynamic>),
      activeCampaign: json['activeCampaign'] == null
          ? null
          : CampaignBrief.fromJson(
              json['activeCampaign'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CenterDetailsToJson(CenterDetails instance) =>
    <String, dynamic>{
      'centerSubDetails': instance.centerSubDetails,
      'activeAlert': instance.activeAlert,
      'activeCampaign': instance.activeCampaign,
    };
