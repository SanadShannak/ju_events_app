import 'package:json_annotation/json_annotation.dart';

part 'team.g.dart';

/// Represents a team with details about the team leader and institutional unit.
@JsonSerializable()
class Team {
  /// The name of the team.
  @JsonKey(name: 'team_name')
  final String name;

  /// The ID of the team leader.
  @JsonKey(name: 'leader_id')
  final String teamLeaderId;

  /// The name of the team leader.
  @JsonKey(name: 'leader_name')
  final String teamLeaderName;

  /// The ID of the institutional unit admin.
  @JsonKey(name: 'admin_id')
  final String institutionalUnitAdminId;

  /// The name of the institutional unit admin.
  @JsonKey(name: 'admin_name')
  final String institutionalUnitAdminName;

  /// The ID of the institutional unit.
  @JsonKey(name: 'unit_id')
  final String institutionalUnitId;

  /// The name of the institutional unit.
  @JsonKey(name: 'unit_name')
  final String institutionalUnitName;

  /// Creates a `Team` with the provided details.
  Team({
    required this.name,
    required this.teamLeaderId,
    required this.teamLeaderName,
    required this.institutionalUnitAdminId,
    required this.institutionalUnitAdminName,
    required this.institutionalUnitId,
    required this.institutionalUnitName,
  });

  /// Creates a `Team` instance from a JSON map.
  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  /// Converts the `Team` instance to a JSON map.
  Map<String, dynamic> toJson() => _$TeamToJson(this);
}
