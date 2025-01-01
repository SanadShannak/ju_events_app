// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
      name: json['team_name'] as String,
      teamLeaderId: json['leader_id'] as String,
      teamLeaderName: json['leader_name'] as String,
      institutionalUnitAdminId: json['admin_id'] as String,
      institutionalUnitAdminName: json['admin_name'] as String,
      institutionalUnitId: json['unit_id'] as String,
      institutionalUnitName: json['unit_name'] as String,
    );

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'team_name': instance.name,
      'leader_id': instance.teamLeaderId,
      'leader_name': instance.teamLeaderName,
      'admin_id': instance.institutionalUnitAdminId,
      'admin_name': instance.institutionalUnitAdminName,
      'unit_id': instance.institutionalUnitId,
      'unit_name': instance.institutionalUnitName,
    };
