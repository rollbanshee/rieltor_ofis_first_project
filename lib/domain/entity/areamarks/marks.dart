import 'package:json_annotation/json_annotation.dart';
part 'marks.g.dart';

@JsonSerializable()
class Marks {
  final int id;
  final String name;

  Marks(this.id, this.name);
  factory Marks.fromJson(Map<String, dynamic> json) => _$MarksFromJson(json);

  Map<String, dynamic> toJson() => _$MarksToJson(this);
}
