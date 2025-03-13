import 'package:json_annotation/json_annotation.dart';
import 'package:pulse_app_mobile/common/models/user.dart';

part 'alert.g.dart';

@JsonSerializable()
class Alert {
  final DateTime? launchDate;
  final DateTime? deadLine;
  final BloodType? bloodType;

  Alert({
    this.launchDate,
    this.deadLine,
    this.bloodType,
  });

  factory Alert.fromJson(Map<String, dynamic> json) => _$AlertFromJson(json);

  Map<String, dynamic> toJson() => _$AlertToJson(this);

  Alert copyWith({
    DateTime? launchDate,
    DateTime? deadLine,
    BloodType? bloodType,
  }) {
    return Alert(
      launchDate: launchDate ?? this.launchDate,
      deadLine: deadLine ?? this.deadLine,
      bloodType: bloodType ?? this.bloodType,
    );
  }
}
