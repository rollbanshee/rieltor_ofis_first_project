// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'similar_ads.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimilarAds _$SimilarAdsFromJson(Map<String, dynamic> json) => SimilarAds(
      json['price'] as int?,
      json['site'] as String?,
      json['originalLink'] as String?,
      json['announceDate'] as String?,
    );

Map<String, dynamic> _$SimilarAdsToJson(SimilarAds instance) =>
    <String, dynamic>{
      'price': instance.price,
      'site': instance.site,
      'originalLink': instance.originalLink,
      'announceDate': instance.announceDate,
    };
