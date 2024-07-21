// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscriptions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subscriptions _$SubscriptionsFromJson(Map<String, dynamic> json) =>
    Subscriptions(
      id: json['id'] as int?,
      filterName: json['filterName'] as String?,
      totalCountOfNewAnnounce: json['totalCountOfNewAnnounce'] as int?,
      isActive: json['isActive'] as bool?,
      interval: json['interval'] as int?,
      lastSeen: json['lastSeen'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$SubscriptionsToJson(Subscriptions instance) =>
    <String, dynamic>{
      'id': instance.id,
      'filterName': instance.filterName,
      'totalCountOfNewAnnounce': instance.totalCountOfNewAnnounce,
      'isActive': instance.isActive,
      'interval': instance.interval,
      'lastSeen': instance.lastSeen,
      'createdAt': instance.createdAt,
    };
