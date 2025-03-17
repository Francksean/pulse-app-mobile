// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'center_sub_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CenterSubDetails _$CenterSubDetailsFromJson(Map<String, dynamic> json) =>
    CenterSubDetails(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      banner: json['banner'] as String?,
      logo: json['logo'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$CenterSubDetailsToJson(CenterSubDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'banner': instance.banner,
      'logo': instance.logo,
      'phone': instance.phone,
      'address': instance.address,
    };
