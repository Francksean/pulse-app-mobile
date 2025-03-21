// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) => Appointment(
      id: (json['id'] as num?)?.toInt(),
      appointmentType: $enumDecodeNullable(
          _$AppointmentTypeEnumMap, json['appointmentType']),
      appointmentDate: json['appointmentDate'] == null
          ? null
          : DateTime.parse(json['appointmentDate'] as String),
      description: json['description'] as String?,
      type: json['type'] as String?,
      centerId: json['centerId'] as String?,
      donorId: json['donorId'] as String?,
    );

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'appointmentType': _$AppointmentTypeEnumMap[instance.appointmentType],
      'appointmentDate': instance.appointmentDate?.toIso8601String(),
      'description': instance.description,
      'type': instance.type,
      'donorId': instance.donorId,
      'centerId': instance.centerId,
    };

const _$AppointmentTypeEnumMap = {
  AppointmentType.LEVY: 'LEVY',
  AppointmentType.DONATION: 'DONATION',
  AppointmentType.ADVICE: 'ADVICE',
};
