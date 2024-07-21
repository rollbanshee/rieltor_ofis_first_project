// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_announces.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionAnnounces _$SubscriptionAnnouncesFromJson(
        Map<String, dynamic> json) =>
    SubscriptionAnnounces(
      json['id'] as int?,
      json['propertyType'] as String?,
      json['cover'] as String?,
      json['price'] as int?,
      json['space'] as String?,
      json['roomCount'] as int?,
      json['address'] as String?,
      json['isRieltorAnnounce'] as bool?,
      json['isInAnyFolders'] as bool?,
      json['announceDate'] as String?,
    );

Map<String, dynamic> _$SubscriptionAnnouncesToJson(
        SubscriptionAnnounces instance) =>
    <String, dynamic>{
      'id': instance.id,
      'propertyType': instance.propertyType,
      'cover': instance.cover,
      'price': instance.price,
      'space': instance.space,
      'roomCount': instance.roomCount,
      'address': instance.address,
      'isRieltorAnnounce': instance.isRieltorAnnounce,
      'isInAnyFolders': instance.isInAnyFolders,
      'announceDate': instance.announceDate,
    };
