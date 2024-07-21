import 'package:json_annotation/json_annotation.dart';

part 'get_folders_by_announces.g.dart';

@JsonSerializable(explicitToJson: true)
class GetFoldersByAnnounces {
  final int? listId;
  final String? listName;

  GetFoldersByAnnounces({required this.listId, required this.listName});

  factory GetFoldersByAnnounces.fromJson(Map<String, dynamic> json) =>
      _$GetFoldersByAnnouncesFromJson(json);

  Map<String, dynamic> toJson() => _$GetFoldersByAnnouncesToJson(this);
}
