// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Alert _$AlertFromJson(Map<String, dynamic> json) => Alert(
      launchDate: json['launchDate'] == null
          ? null
          : DateTime.parse(json['launchDate'] as String),
      deadLine: json['deadLine'] == null
          ? null
          : DateTime.parse(json['deadLine'] as String),
      bloodType: $enumDecodeNullable(_$BloodTypeEnumMap, json['bloodType']),
    );

Map<String, dynamic> _$AlertToJson(Alert instance) => <String, dynamic>{
      'launchDate': instance.launchDate?.toIso8601String(),
      'deadLine': instance.deadLine?.toIso8601String(),
      'bloodType': _$BloodTypeEnumMap[instance.bloodType],
    };

const _$BloodTypeEnumMap = {
  BloodType.aPos: 'A+',
  BloodType.aNeg: 'A-',
  BloodType.bPos: 'B+',
  BloodType.bNeg: 'B-',
  BloodType.abPos: 'AB+',
  BloodType.abNeg: 'AB-',
  BloodType.oPos: 'O+',
  BloodType.oNeg: 'O-',
};
