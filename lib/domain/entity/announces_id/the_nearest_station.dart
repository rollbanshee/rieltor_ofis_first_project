import 'package:json_annotation/json_annotation.dart';

part 'the_nearest_station.g.dart';

@JsonSerializable(explicitToJson: true)
class TheNearestStation {
  final String? name;
  final int? distance;

  TheNearestStation(this.name, this.distance);
  factory TheNearestStation.fromJson(Map<String, dynamic> json) =>
      _$TheNearestStationFromJson(json);

  Map<String, dynamic> toJson() => _$TheNearestStationToJson(this);
}
