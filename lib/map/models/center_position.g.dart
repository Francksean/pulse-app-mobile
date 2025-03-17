// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'center_position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CenterPosition _$CenterPositionFromJson(Map<String, dynamic> json) =>
    CenterPosition(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CenterPositionToJson(CenterPosition instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
