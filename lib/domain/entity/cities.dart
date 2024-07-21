import 'package:json_annotation/json_annotation.dart';

part 'cities.g.dart';

@JsonSerializable()
class Cities {
  final int id;
  final String name;

  Cities({required this.id, required this.name});

  factory Cities.fromJson(Map<String, dynamic> json) => _$CitiesFromJson(json);

  Map<String, dynamic> toJson() => _$CitiesToJson(this);
}
