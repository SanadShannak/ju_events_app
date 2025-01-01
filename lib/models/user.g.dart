// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['full_name'] as String,
      major: json['major_field'] as String,
      institutionalUnitId: json['unit_id'] as String,
      institutionalUnitName: json['unit_name'] as String,
      role: $enumDecode(_$UserRoleEnumMap, json['user_role']),
      interests:
          (json['interests'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'full_name': instance.name,
      'major_field': instance.major,
      'interests': instance.interests,
      'unit_id': instance.institutionalUnitId,
      'unit_name': instance.institutionalUnitName,
      'user_role': _$UserRoleEnumMap[instance.role]!,
    };

const _$UserRoleEnumMap = {
  UserRole.normalUser: 'normal_user',
  UserRole.teamLeader: 'team_leader',
  UserRole.admin: 'admin',
  UserRole.root: 'root',
};
