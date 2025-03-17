import 'package:json_annotation/json_annotation.dart';

part 'center_sub_details.g.dart';

@JsonSerializable()
class CenterSubDetails {
  final int? id;
  final String? name;
  final String? banner;
  final String? logo;
  final String? phone;
  final String? address;

  CenterSubDetails({
    this.id,
    this.name,
    this.banner,
    this.logo,
    this.phone,
    this.address,
  });

  factory CenterSubDetails.fromJson(Map<String, dynamic> json) =>
      _$CenterSubDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CenterSubDetailsToJson(this);

  CenterSubDetails copyWith({
    int? id,
    String? name,
    String? banner,
    String? logo,
    String? phone,
    String? address,
  }) {
    return CenterSubDetails(
        id: id ?? this.id,
        name: name ?? this.name,
        banner: banner ?? this.banner,
        logo: logo ?? this.logo,
        phone: phone ?? this.phone,
        address: address ?? this.address);
  }
}
