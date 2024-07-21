import 'package:json_annotation/json_annotation.dart';

part 'single_folder.g.dart';

@JsonSerializable(explicitToJson: true)
class SingleFolder {
  final int? id;
  final String? propertyType;
  final String? cover;
  final int? price;
  final String? space;
  final int? roomCount;
  final String? address;
  final bool? isRieltorAnnounce;
  final bool? isInAnyFolders;
  final String? announceDate;

  SingleFolder(
      {required this.id,
      required this.propertyType,
      required this.cover,
      required this.price,
      required this.space,
      required this.roomCount,
      required this.address,
      required this.isRieltorAnnounce,
      required this.isInAnyFolders,
      required this.announceDate});

  factory SingleFolder.fromJson(Map<String, dynamic> json) =>
      _$SingleFolderFromJson(json);
  Map<String, dynamic> toJson() => _$SingleFolderToJson(this);
}
