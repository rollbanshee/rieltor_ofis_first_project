// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'region.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Region _$RegionFromJson(Map<String, dynamic> json) => Region(
      json['regionId'] as int,
      json['regionName'] as String,
      (json['settlementDto'] as List<dynamic>)
          .map((e) => Settlements.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RegionToJson(Region instance) => <String, dynamic>{
      'regionId': instance.regionId,
      'regionName': instance.regionName,
      'settlementDto': instance.settlementDto,
    };
