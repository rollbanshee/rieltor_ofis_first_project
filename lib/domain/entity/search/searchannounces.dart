import 'package:json_annotation/json_annotation.dart';

part 'searchannounces.g.dart';

@JsonSerializable()
class SearchAnnounces {
  @JsonKey(disallowNullValue: false)
  int? id;
  @JsonKey(disallowNullValue: false)
  final String? propertyType;
  @JsonKey(disallowNullValue: false)
  final String? cover;
  @JsonKey(disallowNullValue: false)
  final int price;
  @JsonKey(disallowNullValue: false)
  final String? space;
  @JsonKey(disallowNullValue: false)
  final int? roomCount;
  @JsonKey(disallowNullValue: false)
  final String? address;
  @JsonKey(disallowNullValue: false)
  final String? announceDate;
  @JsonKey(disallowNullValue: false)
  final bool? isRieltorAnnounce;
  @JsonKey(disallowNullValue: false)
  bool? isInAnyFolders;

  SearchAnnounces({
    required this.id,
    required this.propertyType,
    required this.cover,
    required this.price,
    required this.space,
    required this.roomCount,
    required this.address,
    required this.announceDate,
    required this.isRieltorAnnounce,
    required this.isInAnyFolders,
  });

  factory SearchAnnounces.fromJson(Map<String, dynamic> json) =>
      _$SearchAnnouncesFromJson(json);

  Map<String, dynamic> toJson() => _$SearchAnnouncesToJson(this);
}
