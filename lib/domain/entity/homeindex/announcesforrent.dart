import 'package:json_annotation/json_annotation.dart';
part 'announcesforrent.g.dart';

@JsonSerializable(explicitToJson: true)
class AnnouncesForRent {
  final int id;
  final String? propertyType;
  final String? cover;
  final int price;
  final String? space;
  final int roomCount;
  final String? address;
  final String? announceDate;
  final bool? isRieltorAnnounce;
  final bool? isInAnyFolders;
  AnnouncesForRent(
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
  factory AnnouncesForRent.fromJson(Map<String, dynamic> json) =>
      _$AnnouncesForRentFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncesForRentToJson(this);
}
