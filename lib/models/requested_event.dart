import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import 'event.dart';
import 'event_request_states.dart';

part 'requested_event.g.dart';

/// Represents a requested event with additional request-specific details.
@JsonSerializable()
class RequestedEvent extends Event {
  /// The date and time when the request was made.
  @JsonKey(
    name: 'request_date_time',
    fromJson: _timestampFromJson,
    toJson: _timestampToJson,
  )
  final Timestamp requestDateTime;

  /// The ID of the person or entity the request was sent from.
  @JsonKey(name: 'initiator_id')
  final String initiatorId;

  /// The name of the person or entity the request was sent from.
  @JsonKey(name: 'initiator_name')
  final String initiatorName;

  /// The ID of the person or entity the request was sent to.
  @JsonKey(name: 'target_id')
  final String targetId;

  /// The name of the person or entity the request was sent to.
  @JsonKey(name: 'target_name')
  final String targetName;

  /// The current state of the event request.
  @JsonKey(name: 'request_state')
  final EventRequestState requestState;

  /// Creates a `RequestedEvent` with event details and request-specific data.
  RequestedEvent({
    required super.name,
    required super.dateTime,
    required super.locationInfo,
    required super.subLocationInfo,
    required super.topics,
    required super.description,
    required super.postedById,
    required super.postedByName,
    required this.requestDateTime,
    required this.initiatorId,
    required this.initiatorName,
    required this.targetId,
    required this.targetName,
    required this.requestState,
  });

  /// Creates a `RequestedEvent` from a JSON map.
  factory RequestedEvent.fromJson(Map<String, dynamic> json) => _$RequestedEventFromJson(json);

  /// Converts the `RequestedEvent` to a JSON map.
  @override
  Map<String, dynamic> toJson() => _$RequestedEventToJson(this);

  /// Converts a JSON value to a Firestore `Timestamp`.
  static Timestamp _timestampFromJson(dynamic json) {
    if (json is Timestamp) return json;
    if (json is int) return Timestamp.fromMillisecondsSinceEpoch(json);
    throw ArgumentError('Invalid timestamp format');
  }

  /// Converts a Firestore `Timestamp` to a JSON-compatible value.
  static int _timestampToJson(Timestamp timestamp) => timestamp.millisecondsSinceEpoch;
}
