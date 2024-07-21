import 'package:json_annotation/json_annotation.dart';

part 'subscriptions.g.dart';

@JsonSerializable(explicitToJson: true)
class Subscriptions {
  final int? id;
  final String? filterName;
  final int? totalCountOfNewAnnounce;
  final bool? isActive;
  final int? interval;
  final String? lastSeen;
  final String? createdAt;

  Subscriptions(
      {required this.id,
      required this.filterName,
      required this.totalCountOfNewAnnounce,
      required this.isActive,
      required this.interval,
      required this.lastSeen,
      required this.createdAt});

  factory Subscriptions.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionsFromJson(json);
  Map<String, dynamic> toJson() => _$SubscriptionsToJson(this);
}
