// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announce_condition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnnounceCondition _$AnnounceConditionFromJson(Map<String, dynamic> json) =>
    AnnounceCondition(
      json['hasGas'] as bool,
      json['hasSecurity'] as bool,
      json['hasStation'] as bool,
      json['hasHeatingSystem'] as bool,
      json['hasElevator'] as bool,
      json['hasGarage'] as bool,
    );

Map<String, dynamic> _$AnnounceConditionToJson(AnnounceCondition instance) =>
    <String, dynamic>{
      'hasGas': instance.hasGas,
      'hasSecurity': instance.hasSecurity,
      'hasStation': instance.hasStation,
      'hasHeatingSystem': instance.hasHeatingSystem,
      'hasElevator': instance.hasElevator,
      'hasGarage': instance.hasGarage,
    };
