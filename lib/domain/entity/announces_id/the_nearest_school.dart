import 'package:json_annotation/json_annotation.dart';

part 'the_nearest_school.g.dart';

@JsonSerializable(explicitToJson: true)
class TheNearestSchool {
  final String? name;
  final int? distance;

  TheNearestSchool(this.name, this.distance);
  factory TheNearestSchool.fromJson(Map<String, dynamic> json) =>
      _$TheNearestSchoolFromJson(json);

  Map<String, dynamic> toJson() => _$TheNearestSchoolToJson(this);
}
