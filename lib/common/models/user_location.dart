import 'package:json_annotation/json_annotation.dart';

part "user_location.g.dart";

@JsonSerializable()
class UserLocation {
  String? city;
  String? conuntry;
  double? latitude;
  double? longitude;

  UserLocation(
      {required this.city,
      required this.conuntry,
      required this.latitude,
      required this.longitude});

  UserLocation copyWith(
      {String? city, String? conuntry, double? latitude, double? longitude}) {
    return UserLocation(
        city: city ?? this.city,
        conuntry: conuntry ?? this.conuntry,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude);
  }

  /// Factory method pour générer une instance de `UserLocation` depuis un JSON.
  factory UserLocation.fromJson(Map<String, dynamic> json) =>
      _$UserLocationFromJson(json);

  /// Méthode pour convertir une instance de `UserLocation` en JSON.
  Map<String, dynamic> toJson() => _$UserLocationToJson(this);
}
