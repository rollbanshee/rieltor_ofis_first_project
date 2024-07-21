import 'package:json_annotation/json_annotation.dart';

part 'get_wishlist.g.dart';

@JsonSerializable(explicitToJson: true)
class Wishlist {
  final int? id;
  final String? propertyType;
  final String? cover;
  final int? price;
  final String? space;
  final int? roomCount;
  final String? address;
  final bool? isRieltorAnnounce;
  final bool? isInAnyFolders;
  final String? announceDate;

  Wishlist(
      {required this.id,
      required this.propertyType,
      required this.cover,
      required this.price,
      required this.space,
      required this.roomCount,
      required this.address,
      required this.isRieltorAnnounce,
      required this.isInAnyFolders,
      required this.announceDate});

  factory Wishlist.fromJson(Map<String, dynamic> json) =>
      _$WishlistFromJson(json);
  Map<String, dynamic> toJson() => _$WishlistToJson(this);
}
