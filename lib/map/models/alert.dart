import 'package:json_annotation/json_annotation.dart';
import 'package:pulse_app_mobile/common/models/user.dart';

part 'alert.g.dart';

@JsonSerializable()
class Alert {
  final DateTime? launchDate;
  final DateTime? deadLine;
  final String? bloodType;
  final String? status;
  final String? title;
  final String? description;

  Alert({
    this.launchDate,
    this.deadLine,
    this.bloodType,
    this.status,
    this.title,
    this.description,
  });

  factory Alert.fromJson(Map<String, dynamic> json) => _$AlertFromJson(json);

  Map<String, dynamic> toJson() => _$AlertToJson(this);

  Alert copyWith({
    DateTime? launchDate,
    DateTime? deadLine,
    String? bloodType,
    String? status,
    String? title,
    String? description,
  }) {
    return Alert(
      launchDate: launchDate ?? this.launchDate,
      deadLine: deadLine ?? this.deadLine,
      bloodType: bloodType ?? this.bloodType,
      status: status ?? this.status,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  String toString() {
    return 'Alert(launchDate: $launchDate, deadLine: $deadLine, bloodType: $bloodType, status: $status, title: $title, description: $description)';
  }
}
