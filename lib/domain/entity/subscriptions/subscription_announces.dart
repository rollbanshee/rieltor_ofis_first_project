import 'package:json_annotation/json_annotation.dart';

part 'subscription_announces.g.dart';

@JsonSerializable(explicitToJson: true)
class SubscriptionAnnounces {
  final int? id;
  final String? propertyType;
  final String? cover;
  final int? price;
  final String? space;
  final int? roomCount;
  final String? address;
  final bool? isRieltorAnnounce;
  bool? isInAnyFolders;
  final String? announceDate;

  SubscriptionAnnounces(
      this.id,
      this.propertyType,
      this.cover,
      this.price,
      this.space,
      this.roomCount,
      this.address,
      this.isRieltorAnnounce,
      this.isInAnyFolders,
      this.announceDate);

  factory SubscriptionAnnounces.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionAnnouncesFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionAnnouncesToJson(this);
}
