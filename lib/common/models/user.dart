import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int? id;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final DateTime? birthDate;
  final GenderType? gender;
  final String? address;
  final BloodType? bloodType;
  final String? userBanner;
  final String? profilePicture;
  final DateTime? lastDonationDate;

  User({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.birthDate,
    this.gender,
    this.address,
    this.bloodType,
    this.userBanner,
    this.profilePicture,
    this.lastDonationDate,
  });

  /// Factory method pour générer une instance de `User` depuis un JSON.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Méthode pour convertir une instance de `User` en JSON.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

/// Enumération pour le genre.
enum GenderType {
  @JsonValue("H")
  hGender,
  @JsonValue("F")
  fGender;
}

/// Enumération pour le groupe sanguin.
enum BloodType {
  @JsonValue("A+")
  aPos,
  @JsonValue("A-")
  aNeg,
  @JsonValue("B+")
  bPos,
  @JsonValue("B-")
  bNeg,
  @JsonValue("AB+")
  abPos,
  @JsonValue("AB-")
  abNeg,
  @JsonValue("O+")
  oPos,
  @JsonValue("O-")
  oNeg;
}
