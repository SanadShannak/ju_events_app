import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

/// Represents an event with details like name, date, location, topics and poster info.
@JsonSerializable()
class Event {
  /// The name of the event.
  @JsonKey(name: 'event_name')
  final String name;

  /// The date and time of the event.
  @JsonKey(name: 'date_time')
  final DateTime? dateTime;

  /// General location information.
  @JsonKey(name: 'location_info')
  final String locationInfo;

  /// Specific location details.
  @JsonKey(name: 'sub_location_info')
  final String subLocationInfo;

  /// Topics associated with the event.
  final List<String> topics;

  /// A description of the event.
  final String description;

  /// The ID of the person who posted the event.
  @JsonKey(name: 'posted_by_id')
  final String postedById;

  /// The name of the person who posted the event.
  @JsonKey(name: 'posted_by_name')
  final String postedByName;

  /// Creates an `Event` with the given details.
  Event({
    required this.name,
    required this.dateTime,
    required this.locationInfo,
    required this.subLocationInfo,
    required this.topics,
    required this.description,
    required this.postedById,
    required this.postedByName,
  });

  /// Creates an `Event` from a JSON map.
  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  /// Converts the `Event` to a JSON map.
  Map<String, dynamic> toJson() => _$EventToJson(this);
}
