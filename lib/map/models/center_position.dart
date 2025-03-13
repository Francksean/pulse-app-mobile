import 'dart:ffi';
import 'package:json_annotation/json_annotation.dart';

part 'center_position.g.dart';
@JsonSerializable()
class CenterPosition {
  final String? centerId;
  final String? centerName;
  final double? latitude;
  final double? longitude;

  CenterPosition({
    required this.centerId,
    required this.centerName,
    required this.latitude,
    required this.longitude,
  });

  // Méthode copyWith
  CenterPosition copyWith({
    String? centerId,
    String? centerName,
    double? latitude,
    double? longitude,
  }) {
    return CenterPosition(
      centerId: centerId ?? this.centerId,
      centerName: centerName ?? this.centerName,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  // Méthode fromJson générée par json_serializable
  factory CenterPosition.fromJson(Map<String, dynamic> json) =>
      _$CenterPositionFromJson(json);

  // Méthode toJson générée par json_serializable
  Map<String, dynamic> toJson() => _$CenterPositionToJson(this);
}
