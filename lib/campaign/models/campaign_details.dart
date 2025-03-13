import 'package:json_annotation/json_annotation.dart';
import 'package:pulse_app_mobile/campaign/enums/campaign_status.dart';
import 'package:pulse_app_mobile/map/models/center_details.dart';

part 'campaign_details.g.dart';

@JsonSerializable()
class CampaignDetails {
  final int? id;
  final String? title;
  final String? description;
  final String? banner;
  final CenterDetails? center;
  final DateTime? startDate;
  final DateTime? endDate;
  final CampaignStatus? status;

  CampaignDetails({
    this.id,
    this.title,
    this.description,
    this.banner,
    this.center,
    this.startDate,
    this.endDate,
    this.status,
  });

  // Méthode pour la désérialisation JSON
  factory CampaignDetails.fromJson(Map<String, dynamic> json) =>
      _$CampaignDetailsFromJson(json);

  // Méthode pour la sérialisation JSON
  Map<String, dynamic> toJson() => _$CampaignDetailsToJson(this);

  // Méthode copyWith pour créer une copie modifiée de l'objet
  CampaignDetails copyWith({
    int? id,
    String? title,
    String? description,
    String? banner,
    CenterDetails? center,
    DateTime? startDate,
    DateTime? endDate,
    CampaignStatus? status,
  }) {
    return CampaignDetails(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      banner: banner ?? this.banner,
      center: center ?? this.center,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
    );
  }
}
