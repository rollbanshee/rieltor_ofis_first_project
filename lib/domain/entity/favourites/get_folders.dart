import 'package:json_annotation/json_annotation.dart';

part 'get_folders.g.dart';

@JsonSerializable(explicitToJson: true)
class GetFolders {
  final int? listId;
  final String? listName;
  final int? announceCount;

  factory GetFolders.fromJson(Map<String, dynamic> json) =>
      _$GetFoldersFromJson(json);

  GetFolders(this.listId, this.listName, this.announceCount);

  Map<String, dynamic> toJson() => _$GetFoldersToJson(this);
}
