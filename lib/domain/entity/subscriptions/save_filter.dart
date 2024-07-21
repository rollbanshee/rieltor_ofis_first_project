import 'package:json_annotation/json_annotation.dart';

part 'save_filter.g.dart';

SaveFilter parameters1 = SaveFilter();

@JsonSerializable(explicitToJson: true)
class SaveFilter {
  String? filterName;
  int? announceCount;
  SaveFilter({filterName, announceCount});
  factory SaveFilter.fromJson(Map<String, dynamic> json) =>
      _$SaveFilterFromJson(json);

  Map<String, dynamic> toJson() => _$SaveFilterToJson(this);
}
