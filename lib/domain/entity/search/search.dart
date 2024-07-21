import 'package:json_annotation/json_annotation.dart';

part 'search.g.dart';

ForSearch parameters = ForSearch();

@JsonSerializable(explicitToJson: true)
class ForSearch {
  String announceType = "2";
  String? pageNumber = "1";
  String? pageSize = "10";
  String? sortType = "1";
  String kredit = "0";
  String document = "0";
  String? propertyType = "0";
  String? cityId = "1";
  String? announcer = "0";
  String? minPrice = "0";
  String? maxPrice = "2000000000";
  String? minSpace = "0";
  String? maxSpace = "100000";
  String? noFirstFloor = "false";
  String? noTopFloor = "false";
  String? isTopFloor = "false";
  List<dynamic> currentFloor = List.empty(growable: true);
  List<dynamic> floorCount = List.empty(growable: true);
  List<dynamic> roomCount = List.empty(growable: true);
  List<dynamic> metroId = List.empty(growable: true);

  List<dynamic> markId = List.empty(growable: true);
  List<dynamic> regionId = List.empty(growable: true);

  List<dynamic> settlementId = List.empty(growable: true);
  ForSearch(
      {announceType,
      roomCount,
      pageNumber,
      pageSize,
      sortType,
      kredit,
      document,
      propertyType,
      metroId,
      markId,
      regionId,
      settlementId,
      cityId,
      announcer,
      minPrice,
      maxPrice,
      minSpace,
      maxSpace,
      currentFloor});

  factory ForSearch.fromJson(Map<String, dynamic> json) =>
      _$ForSearchFromJson(json);

  Map<String, dynamic> toJson() => _$ForSearchToJson(this);
}
