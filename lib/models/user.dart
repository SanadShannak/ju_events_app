import 'package:json_annotation/json_annotation.dart';
import 'package:temp_project/models/user_roles.dart';

part 'user.g.dart';

/// Represents a user with personal, academic and role information.
@JsonSerializable()
class User {
  /// The user's name.
  @JsonKey(name: 'full_name')
  final String name;

  /// The user's major field of study.
  @JsonKey(name: 'major_field')
  final String major;

  /// A list of the user's interests.
  @JsonKey(name: 'interests')
  final List<String> interests;

  /// The ID of the user's institutional unit.
  @JsonKey(name: 'unit_id')
  final String institutionalUnitId;

  /// The name of the user's institutional unit.
  @JsonKey(name: 'unit_name')
  final String institutionalUnitName;

  /// The user's role in the system (e.g., student, admin).
  @JsonKey(name: 'user_role')
  final UserRole role;

  /// Creates a `User` with the provided details.
  User({
    required this.name,
    required this.major,
    required this.institutionalUnitId,
    required this.institutionalUnitName,
    required this.role,
    required this.interests,
  });

  /// Creates a `User` instance from a JSON map.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Converts the `User` instance to a JSON map.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
