import 'package:json_annotation/json_annotation.dart';

part 'campaign_brief.g.dart';

@JsonSerializable()
class CampaignBrief {
  final int? id;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? title;
  final String? description;

  CampaignBrief({
    this.id,
    this.startDate,
    this.endDate,
    this.title,
    this.description,
  });

  factory CampaignBrief.fromJson(Map<String, dynamic> json) =>
      _$CampaignBriefFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignBriefToJson(this);

  CampaignBrief copyWith({
    int? id,
    DateTime? launchDate,
    DateTime? startDate,
    DateTime? endDate,
    String? title,
    String? description,
  }) {
    return CampaignBrief(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}
