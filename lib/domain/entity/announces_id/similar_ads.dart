import 'package:json_annotation/json_annotation.dart';

part 'similar_ads.g.dart';

@JsonSerializable(explicitToJson: true)
class SimilarAds {
  final int? price;
  final String? site;
  final String? originalLink;
  final String? announceDate;

  SimilarAds(this.price, this.site, this.originalLink, this.announceDate);
  factory SimilarAds.fromJson(Map<String, dynamic> json) =>
      _$SimilarAdsFromJson(json);

  Map<String, dynamic> toJson() => _$SimilarAdsToJson(this);
}
