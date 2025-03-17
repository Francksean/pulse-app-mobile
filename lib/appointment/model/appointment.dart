import 'package:json_annotation/json_annotation.dart';

part 'appointment.g.dart'; // Fichier généré par json_serializable

@JsonSerializable()
class Appointment {
  final int? id;
  final DateTime? appointmentDate;
  final String? description;
  final String? type;
  final String? donorId;
  final String? centerId;

  Appointment(
      {this.id,
      this.appointmentDate,
      this.description,
      this.type,
      this.centerId,
      this.donorId});

  // Méthode pour la désérialisation JSON
  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);

  // Méthode pour la sérialisation JSON
  Map<String, dynamic> toJson() => _$AppointmentToJson(this);

  // Méthode copyWith pour créer une copie modifiée de l'objet
  Appointment copyWith(
      {int? id,
      DateTime? appointmentDate,
      String? description,
      String? type,
      String? donorId,
      String? centerId}) {
    return Appointment(
        id: id ?? this.id,
        appointmentDate: appointmentDate ?? this.appointmentDate,
        description: description ?? this.description,
        type: type ?? this.type,
        centerId: centerId ?? this.centerId,
        donorId: donorId ?? this.donorId);
  }
}
