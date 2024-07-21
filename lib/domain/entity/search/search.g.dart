// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForSearch _$ForSearchFromJson(Map<String, dynamic> json) => ForSearch(
      announceType: json['announceType'],
      roomCount: json['roomCount'],
      pageNumber: json['pageNumber'],
      pageSize: json['pageSize'],
      sortType: json['sortType'],
      kredit: json['kredit'],
      document: json['document'],
      propertyType: json['propertyType'],
      metroId: json['metroId'],
      markId: json['markId'],
      regionId: json['regionId'],
      settlementId: json['settlementId'],
      cityId: json['cityId'],
      announcer: json['announcer'],
      minPrice: json['minPrice'],
      maxPrice: json['maxPrice'],
      minSpace: json['minSpace'],
      maxSpace: json['maxSpace'],
      currentFloor: json['currentFloor'],
    )
      ..noFirstFloor = json['noFirstFloor'] as String?
      ..noTopFloor = json['noTopFloor'] as String?
      ..isTopFloor = json['isTopFloor'] as String?
      ..floorCount = json['floorCount'] as List<dynamic>;

Map<String, dynamic> _$ForSearchToJson(ForSearch instance) => <String, dynamic>{
      'announceType': instance.announceType,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'sortType': instance.sortType,
      'kredit': instance.kredit,
      'document': instance.document,
      'propertyType': instance.propertyType,
      'cityId': instance.cityId,
      'announcer': instance.announcer,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
      'minSpace': instance.minSpace,
      'maxSpace': instance.maxSpace,
      'noFirstFloor': instance.noFirstFloor,
      'noTopFloor': instance.noTopFloor,
      'isTopFloor': instance.isTopFloor,
      'currentFloor': instance.currentFloor,
      'floorCount': instance.floorCount,
      'roomCount': instance.roomCount,
      'metroId': instance.metroId,
      'markId': instance.markId,
      'regionId': instance.regionId,
      'settlementId': instance.settlementId,
    };
