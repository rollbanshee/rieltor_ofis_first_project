// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearby_locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NearbyLocations _$NearbyLocationsFromJson(Map<String, dynamic> json) =>
    NearbyLocations(
      json['theNearestStation'] == null
          ? null
          : TheNearestStation.fromJson(
              json['theNearestStation'] as Map<String, dynamic>),
      json['theNearestSchool'] == null
          ? null
          : TheNearestSchool.fromJson(
              json['theNearestSchool'] as Map<String, dynamic>),
      json['theNearestPark'] == null
          ? null
          : TheNearestPark.fromJson(
              json['theNearestPark'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NearbyLocationsToJson(NearbyLocations instance) =>
    <String, dynamic>{
      'theNearestStation': instance.theNearestStation?.toJson(),
      'theNearestSchool': instance.theNearestSchool?.toJson(),
      'theNearestPark': instance.theNearestPark?.toJson(),
    };
