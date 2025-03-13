// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'center_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CenterDetails _$CenterDetailsFromJson(Map<String, dynamic> json) =>
    CenterDetails(
      centerId: json['centerId'] as String?,
      centerName: json['centerName'] as String?,
      bannerUrl: json['bannerUrl'] as String?,
      logoUrl: json['logoUrl'] as String?,
      isOpen: json['isOpen'] as bool?,
      activeAlert: json['activeAlert'] == null
          ? null
          : Alert.fromJson(json['activeAlert'] as Map<String, dynamic>),
      activeCampaign: json['activeCampaign'] == null
          ? null
          : CampaignBrief.fromJson(
              json['activeCampaign'] as Map<String, dynamic>),
      phone: json['phone'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$CenterDetailsToJson(CenterDetails instance) =>
    <String, dynamic>{
      'centerId': instance.centerId,
      'centerName': instance.centerName,
      'bannerUrl': instance.bannerUrl,
      'logoUrl': instance.logoUrl,
      'isOpen': instance.isOpen,
      'activeAlert': instance.activeAlert,
      'activeCampaign': instance.activeCampaign,
      'phone': instance.phone,
      'address': instance.address,
    };
