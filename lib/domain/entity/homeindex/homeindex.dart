import 'package:json_annotation/json_annotation.dart';
import 'package:rieltor_ofis/domain/entity/homeindex/announcesforrent.dart';
import 'announcesforsale.dart';

part 'homeindex.g.dart';

@JsonSerializable(explicitToJson: true)
class HomeIndex {
  List<AnnouncesForSale> announcesForSale;
  List<AnnouncesForRent> announcesForRent;
  HomeIndex({required this.announcesForSale, required this.announcesForRent});
  factory HomeIndex.fromJson(Map<String, dynamic> json) =>
      _$HomeIndexFromJson(json);

  Map<String, dynamic> toJson() => _$HomeIndexToJson(this);
}
