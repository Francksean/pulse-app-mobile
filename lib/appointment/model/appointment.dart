import 'package:json_annotation/json_annotation.dart';

part 'appointment.g.dart'; // Fichier généré par json_serializable

@JsonSerializable()
class Appointment {
  final int? id;
  final DateTime appointmentDate;
  final String description;
  final String type;

  Appointment({
    this.id,
    required this.appointmentDate,
    required this.description,
    required this.type,
  });

  // Méthode pour la désérialisation JSON
  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);

  // Méthode pour la sérialisation JSON
  Map<String, dynamic> toJson() => _$AppointmentToJson(this);

  // Méthode copyWith pour créer une copie modifiée de l'objet
  Appointment copyWith({
    int? id,
    DateTime? appointmentDate,
    String? description,
    String? type,
  }) {
    return Appointment(
      id: id ?? this.id,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      description: description ?? this.description,
      type: type ?? this.type,
    );
  }
}
