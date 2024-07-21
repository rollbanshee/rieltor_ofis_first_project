import 'package:json_annotation/json_annotation.dart';
part 'metro.g.dart';

@JsonSerializable()
class Metro {
  final int id;
  final String name;

  Metro(this.id, this.name);
  factory Metro.fromJson(Map<String, dynamic> json) => _$MetroFromJson(json);

  Map<String, dynamic> toJson() => _$MetroToJson(this);
}
