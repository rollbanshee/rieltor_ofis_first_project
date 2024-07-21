import 'package:json_annotation/json_annotation.dart';
part 'settlements.g.dart';

@JsonSerializable()
class Settlements {
  final int settlementId;
  final String settlementName;

  Settlements(this.settlementId, this.settlementName);

  factory Settlements.fromJson(Map<String, dynamic> json) =>
      _$SettlementsFromJson(json);

  Map<String, dynamic> toJson() => _$SettlementsToJson(this);
}
