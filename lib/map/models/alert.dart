import 'package:json_annotation/json_annotation.dart';
import 'package:pulse_app_mobile/common/models/user.dart';

part 'alert.g.dart';

@JsonSerializable()
class Alert {
  final int? id;
  final DateTime? launchDate;
  final DateTime? deadline;
  final String? bloodType;
  final String? status;
  final String? title;
  final String? description;

  Alert({
    this.id,
    this.launchDate,
    this.deadline,
    this.bloodType,
    this.status,
    this.title,
    this.description,
  });

  factory Alert.fromJson(Map<String, dynamic> json) => _$AlertFromJson(json);

  Map<String, dynamic> toJson() => _$AlertToJson(this);

  Alert copyWith({
    int? id,
    DateTime? launchDate,
    DateTime? deadline,
    String? bloodType,
    String? status,
    String? title,
    String? description,
  }) {
    return Alert(
      id: id ?? this.id,
      launchDate: launchDate ?? this.launchDate,
      deadline: deadline ?? this.deadline,
      bloodType: bloodType ?? this.bloodType,
      status: status ?? this.status,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  String toString() {
    return 'Alert(launchDate: $launchDate, deadline: $deadline, bloodType: $bloodType, status: $status, title: $title, description: $description)';
  }
}
