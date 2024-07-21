import 'package:json_annotation/json_annotation.dart';
part 'announcesforsale.g.dart';

@JsonSerializable(explicitToJson: true)
class AnnouncesForSale {
  final int id;
  final String? propertyType;
  final String? cover;
  final int price;
  final String? space;
  final int roomCount;
  final String? address;
  final String announceDate;
  final bool? isRieltorAnnounce;
  final bool? isInAnyFolders;
  AnnouncesForSale(
      {required this.id,
      required this.propertyType,
      required this.cover,
      required this.price,
      required this.space,
      required this.roomCount,
      required this.address,
      required this.announceDate,
      required this.isRieltorAnnounce,
      required this.isInAnyFolders});
  factory AnnouncesForSale.fromJson(Map<String, dynamic> json) =>
      _$AnnouncesForSaleFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncesForSaleToJson(this);
}
