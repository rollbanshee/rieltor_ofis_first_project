// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announces_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnnouncesId _$AnnouncesIdFromJson(Map<String, dynamic> json) => AnnouncesId(
      json['propertyType'] as String?,
      json['space'] as String?,
      json['floorCount'] as int?,
      json['currentFloor'] as int?,
      json['price'] as int?,
      json['metro'] as String?,
      json['settlement'] as String?,
      json['city'] as String?,
      json['region'] as String?,
      json['logoImages'] as List<dynamic>?,
      json['text'] as String?,
      json['address'] as String?,
      json['owner'] as String?,
      json['mobile'] as String?,
      json['ownerType'] as String?,
      json['roomCount'] as int?,
      json['parserSite'] as String?,
      json['complex'] as String?,
      json['announceDate'] as String?,
      json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      json['nearbyLocations'] == null
          ? null
          : NearbyLocations.fromJson(
              json['nearbyLocations'] as Map<String, dynamic>),
      json['announceCondition'] == null
          ? null
          : AnnounceCondition.fromJson(
              json['announceCondition'] as Map<String, dynamic>),
      (json['similarAds'] as List<dynamic>?)
          ?.map((e) => SimilarAds.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnnouncesIdToJson(AnnouncesId instance) =>
    <String, dynamic>{
      'propertyType': instance.propertyType,
      'space': instance.space,
      'floorCount': instance.floorCount,
      'currentFloor': instance.currentFloor,
      'price': instance.price,
      'metro': instance.metro,
      'settlement': instance.settlement,
      'city': instance.city,
      'region': instance.region,
      'logoImages': instance.logoImages,
      'text': instance.text,
      'address': instance.address,
      'owner': instance.owner,
      'mobile': instance.mobile,
      'ownerType': instance.ownerType,
      'roomCount': instance.roomCount,
      'parserSite': instance.parserSite,
      'complex': instance.complex,
      'announceDate': instance.announceDate,
      'location': instance.location?.toJson(),
      'nearbyLocations': instance.nearbyLocations?.toJson(),
      'announceCondition': instance.announceCondition?.toJson(),
      'similarAds': instance.similarAds?.map((e) => e.toJson()).toList(),
    };
