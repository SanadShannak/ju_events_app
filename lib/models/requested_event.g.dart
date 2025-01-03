// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requested_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestedEvent _$RequestedEventFromJson(Map<String, dynamic> json) =>
    RequestedEvent(
      name: json['event_name'] as String,
      dateTime: DateTime.parse(json['date_time'] as String),
      locationInfo: json['location_info'] as String,
      subLocationInfo: json['sub_location_info'] as String,
      topics:
          (json['topics'] as List<dynamic>).map((e) => e as String).toList(),
      description: json['description'] as String,
      postedById: json['posted_by_id'] as String,
      postedByName: json['posted_by_name'] as String,
      requestDateTime:
          RequestedEvent._timestampFromJson(json['request_date_time']),
      initiatorId: json['initiator_id'] as String,
      initiatorName: json['initiator_name'] as String,
      targetId: json['target_id'] as String,
      targetName: json['target_name'] as String,
      requestState:
          $enumDecode(_$EventRequestStateEnumMap, json['request_state']),
    );

Map<String, dynamic> _$RequestedEventToJson(RequestedEvent instance) =>
    <String, dynamic>{
      'event_name': instance.name,
      'date_time': instance.dateTime.toIso8601String(),
      'location_info': instance.locationInfo,
      'sub_location_info': instance.subLocationInfo,
      'topics': instance.topics,
      'description': instance.description,
      'posted_by_id': instance.postedById,
      'posted_by_name': instance.postedByName,
      'request_date_time':
          RequestedEvent._timestampToJson(instance.requestDateTime),
      'initiator_id': instance.initiatorId,
      'initiator_name': instance.initiatorName,
      'target_id': instance.targetId,
      'target_name': instance.targetName,
      'request_state': _$EventRequestStateEnumMap[instance.requestState]!,
    };

const _$EventRequestStateEnumMap = {
  EventRequestState.pending: 'pending',
  EventRequestState.accepted: 'accepted',
  EventRequestState.rejected: 'rejected',
  EventRequestState.canceled: 'canceled',
};
