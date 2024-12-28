import 'package:json_annotation/json_annotation.dart';

part 'institutional_unit.g.dart';

/// Represents an institutional unit with a list of majors and admin details.
@JsonSerializable()
class InstitutionalUnit {
  /// The Institutional Unit name.
  @JsonKey(name: 'unit_name')
  final String name;

  /// The list of majors offered by the unit.
  @JsonKey(name: 'majors_list')
  final List<String> majors;

  /// The ID of the unit's administrator.
  @JsonKey(name: 'admin_id')
  final String adminId;

  /// The name of the unit's administrator.
  @JsonKey(name: 'admin_name')
  final String adminName;

  /// Creates an `InstitutionalUnit` with the given [majors], [adminId], and [adminName].
  InstitutionalUnit({
    required this.name,
    required this.majors,
    required this.adminId,
    required this.adminName,
  });

  /// Creates an `InstitutionalUnit` from a JSON map.
  factory InstitutionalUnit.fromJson(Map<String, dynamic> json) => _$InstitutionalUnitFromJson(json);

  /// Converts the `InstitutionalUnit` to a JSON map.
  Map<String, dynamic> toJson() => _$InstitutionalUnitToJson(this);
}
