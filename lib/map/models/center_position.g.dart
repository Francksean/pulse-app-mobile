// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'center_position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CenterPosition _$CenterPositionFromJson(Map<String, dynamic> json) =>
    CenterPosition(
      centerId: json['centerId'] as String?,
      centerName: json['centerName'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CenterPositionToJson(CenterPosition instance) =>
    <String, dynamic>{
      'centerId': instance.centerId,
      'centerName': instance.centerName,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
