import 'package:json_annotation/json_annotation.dart';
import 'package:rieltor_ofis/domain/entity/areamarks/settlements.dart';
part 'region.g.dart';

@JsonSerializable()
class Region {
  final int regionId;
  final String regionName;
  final List<Settlements> settlementDto;

  Region(this.regionId, this.regionName, this.settlementDto);
  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);

  Map<String, dynamic> toJson() => _$RegionToJson(this);
}
