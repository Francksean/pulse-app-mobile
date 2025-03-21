// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Alert _$AlertFromJson(Map<String, dynamic> json) => Alert(
      id: (json['id'] as num?)?.toInt(),
      launchDate: json['launchDate'] == null
          ? null
          : DateTime.parse(json['launchDate'] as String),
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      bloodType: json['bloodType'] as String?,
      status: json['status'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$AlertToJson(Alert instance) => <String, dynamic>{
      'id': instance.id,
      'launchDate': instance.launchDate?.toIso8601String(),
      'deadline': instance.deadline?.toIso8601String(),
      'bloodType': instance.bloodType,
      'status': instance.status,
      'title': instance.title,
      'description': instance.description,
    };
