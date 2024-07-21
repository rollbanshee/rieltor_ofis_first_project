import 'package:json_annotation/json_annotation.dart';

part 'announce_condition.g.dart';

@JsonSerializable(explicitToJson: true)
class AnnounceCondition {
  final bool hasGas;
  final bool hasSecurity;
  final bool hasStation;
  final bool hasHeatingSystem;
  final bool hasElevator;
  final bool hasGarage;

  AnnounceCondition(this.hasGas, this.hasSecurity, this.hasStation,
      this.hasHeatingSystem, this.hasElevator, this.hasGarage);
  factory AnnounceCondition.fromJson(Map<String, dynamic> json) =>
      _$AnnounceConditionFromJson(json);

  Map<String, dynamic> toJson() => _$AnnounceConditionToJson(this);
}
