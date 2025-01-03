// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      name: json['event_name'] as String,
      dateTime: DateTime.parse(json['date_time'] as String),
      locationInfo: json['location_info'] as String,
      subLocationInfo: json['sub_location_info'] as String,
      topics:
          (json['topics'] as List<dynamic>).map((e) => e as String).toList(),
      description: json['description'] as String,
      postedById: json['posted_by_id'] as String,
      postedByName: json['posted_by_name'] as String,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'event_name': instance.name,
      'date_time': instance.dateTime.toIso8601String(),
      'location_info': instance.locationInfo,
      'sub_location_info': instance.subLocationInfo,
      'topics': instance.topics,
      'description': instance.description,
      'posted_by_id': instance.postedById,
      'posted_by_name': instance.postedByName,
    };
