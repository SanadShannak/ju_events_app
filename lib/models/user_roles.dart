import 'package:json_annotation/json_annotation.dart';

/// Defines the roles a user can have in the system.
enum UserRole {
  /// A regular user with standard privileges.
  @JsonValue('normal_user')
  normalUser,

  /// A user who leads a team.
  @JsonValue('team_leader')
  teamLeader,

  /// A user with administrative privileges.
  @JsonValue('admin')
  admin,

  /// A user with the highest level of privileges.
  @JsonValue('root')
  root,
}
