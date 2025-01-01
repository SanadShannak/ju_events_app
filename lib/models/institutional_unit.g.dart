// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'institutional_unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstitutionalUnit _$InstitutionalUnitFromJson(Map<String, dynamic> json) =>
    InstitutionalUnit(
      name: json['unit_name'] as String,
      majors: (json['majors_list'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      adminId: json['admin_id'] as String,
      adminName: json['admin_name'] as String,
    );

Map<String, dynamic> _$InstitutionalUnitToJson(InstitutionalUnit instance) =>
    <String, dynamic>{
      'unit_name': instance.name,
      'majors_list': instance.majors,
      'admin_id': instance.adminId,
      'admin_name': instance.adminName,
    };
