import 'dart:ffi';
import 'package:json_annotation/json_annotation.dart';

part 'center_position.g.dart';

@JsonSerializable()
class CenterPosition {
  final int? id;
  final String? name;
  final double? latitude;
  final double? longitude;

  CenterPosition({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  // Méthode copyWith
  CenterPosition copyWith({
    int? id,
    String? name,
    double? latitude,
    double? longitude,
  }) {
    return CenterPosition(
      id: id ?? this.id,
      name: name ?? this.name,
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
