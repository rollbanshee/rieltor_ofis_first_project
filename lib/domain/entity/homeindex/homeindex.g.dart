// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homeindex.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeIndex _$HomeIndexFromJson(Map<String, dynamic> json) => HomeIndex(
      announcesForSale: (json['announcesForSale'] as List<dynamic>)
          .map((e) => AnnouncesForSale.fromJson(e as Map<String, dynamic>))
          .toList(),
      announcesForRent: (json['announcesForRent'] as List<dynamic>)
          .map((e) => AnnouncesForRent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeIndexToJson(HomeIndex instance) => <String, dynamic>{
      'announcesForSale':
          instance.announcesForSale.map((e) => e.toJson()).toList(),
      'announcesForRent':
          instance.announcesForRent.map((e) => e.toJson()).toList(),
    };
