import 'package:json_annotation/json_annotation.dart';

part 'the_nearest_park.g.dart';

@JsonSerializable(explicitToJson: true)
class TheNearestPark {
  final String? name;
  final int? distance;

  TheNearestPark(this.name, this.distance);
  factory TheNearestPark.fromJson(Map<String, dynamic> json) =>
      _$TheNearestParkFromJson(json);

  Map<String, dynamic> toJson() => _$TheNearestParkToJson(this);
}
