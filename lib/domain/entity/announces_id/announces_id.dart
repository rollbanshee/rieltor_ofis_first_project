import 'package:json_annotation/json_annotation.dart';
import 'announce_condition.dart';
import 'location.dart';
import 'nearby_locations.dart';
import 'similar_ads.dart';

part 'announces_id.g.dart';

@JsonSerializable(explicitToJson: true)
class AnnouncesId {
  final String? propertyType;
  final String? space;
  final int? floorCount;
  final int? currentFloor;
  final int? price;
  final String? metro;
  final String? settlement;
  final String? city;
  final String? region;
  final List<dynamic>? logoImages;
  final String? text;
  final String? address;
  final String? owner;
  final String? mobile;
  final String? ownerType;
  final int? roomCount;
  final String? parserSite;
  final String? complex;
  final String? announceDate;
  final Location? location;
  final NearbyLocations? nearbyLocations;
  final AnnounceCondition? announceCondition;
  final List<SimilarAds>? similarAds;

  AnnouncesId(
      this.propertyType,
      this.space,
      this.floorCount,
      this.currentFloor,
      this.price,
      this.metro,
      this.settlement,
      this.city,
      this.region,
      this.logoImages,
      this.text,
      this.address,
      this.owner,
      this.mobile,
      this.ownerType,
      this.roomCount,
      this.parserSite,
      this.complex,
      this.announceDate,
      this.location,
      this.nearbyLocations,
      this.announceCondition,
      this.similarAds);
  factory AnnouncesId.fromJson(Map<String, dynamic> json) =>
      _$AnnouncesIdFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncesIdToJson(this);
}
