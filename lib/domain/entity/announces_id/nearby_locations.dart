import 'package:json_annotation/json_annotation.dart';
import 'package:rieltor_ofis/domain/entity/announces_id/the_nearest_park.dart';
import 'the_nearest_school.dart';
import 'the_nearest_station.dart';

part 'nearby_locations.g.dart';

@JsonSerializable(explicitToJson: true)
class NearbyLocations {
  final TheNearestStation? theNearestStation;
  final TheNearestSchool? theNearestSchool;
  final TheNearestPark? theNearestPark;

  NearbyLocations(
      this.theNearestStation, this.theNearestSchool, this.theNearestPark);
  factory NearbyLocations.fromJson(Map<String, dynamic> json) =>
      _$NearbyLocationsFromJson(json);

  Map<String, dynamic> toJson() => _$NearbyLocationsToJson(this);
}
