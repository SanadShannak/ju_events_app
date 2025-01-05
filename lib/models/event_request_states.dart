import 'package:json_annotation/json_annotation.dart';

/// Defines the possible states of an event request.
enum EventRequestState {
  /// Request has been sent, awaiting response from the admin.
  @JsonValue('pending')
  pending,

  /// Request has been accepted by the admin.
  @JsonValue('accepted')
  accepted,

  /// Request has been declined by the admin.
  @JsonValue('rejected')
  rejected,

  /// Request has been cancelled by the team leader.
  @JsonValue('cancelled')
  cancelled,
}
