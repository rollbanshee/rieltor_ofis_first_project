// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searchannounces.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchAnnounces _$SearchAnnouncesFromJson(Map<String, dynamic> json) =>
    SearchAnnounces(
      id: json['id'] as int?,
      propertyType: json['propertyType'] as String?,
      cover: json['cover'] as String?,
      price: json['price'] as int,
      space: json['space'] as String?,
      roomCount: json['roomCount'] as int?,
      address: json['address'] as String?,
      announceDate: json['announceDate'] as String?,
      isRieltorAnnounce: json['isRieltorAnnounce'] as bool?,
      isInAnyFolders: json['isInAnyFolders'] as bool?,
    );

Map<String, dynamic> _$SearchAnnouncesToJson(SearchAnnounces instance) =>
    <String, dynamic>{
      'id': instance.id,
      'propertyType': instance.propertyType,
      'cover': instance.cover,
      'price': instance.price,
      'space': instance.space,
      'roomCount': instance.roomCount,
      'address': instance.address,
      'announceDate': instance.announceDate,
      'isRieltorAnnounce': instance.isRieltorAnnounce,
      'isInAnyFolders': instance.isInAnyFolders,
    };
