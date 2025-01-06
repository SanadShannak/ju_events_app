import 'package:flutter/material.dart';

import '../../models/event.dart';

class EventProvider {
  String? _name;
  DateTime? _date;
  TimeOfDay? _startingTime;
  String? _locationInfo;
  String? subLocationInfo;
  final Set<String> _topics = {};
  String? description;
  String? _postedById;
  String? _postedByName;

  // Add topic with validation to avoid duplicates
  void addTopic(String topicName) {
    if (topicName.trim().isNotEmpty && !_topics.contains(topicName)) {
      _topics.add(topicName);
    } else {
      throw ArgumentError("Topic name cannot be empty or duplicate");
    }
  }

  // Remove topic
  void removeTopic(String topicName) {
    _topics.remove(topicName);
  }

  // Setters with validation
  set name(String? value) {
    if (value != null && value.trim().isNotEmpty) {
      _name = value;
    } else {
      throw ArgumentError("Event Name cannot be empty");
    }
  }

  set date(DateTime? value) {
    if (value != null && value.isAfter(DateTime.now())) {
      _date = value;
    } else {
      throw ArgumentError("Date must be in the future");
    }
  }

  set startingTime(TimeOfDay? value) {
    if (value != null) {
      _startingTime = value;
    } else {
      throw ArgumentError("Pick the Starting Event Time.");
    }
  }

  set locationInfo(String? value) {
    if (value != null && value.trim().isNotEmpty) {
      _locationInfo = value;
    } else {
      throw ArgumentError("Location information cannot be empty");
    }
  }

  set postedById(String? value) {
    if (value != null && value.trim().isNotEmpty) {
      _postedById = value;
    } else {
      throw ArgumentError("PostedBy Id cannot be empty");
    }
  }

  set postedByName(String? value) {
    if (value != null && value.trim().isNotEmpty) {
      _postedByName = value;
    } else {
      throw ArgumentError("PostedBy Name cannot be empty");
    }
  }

  // Getters
  String? get name => _name;
  DateTime? get date => _date;
  TimeOfDay? get time => _startingTime;
  String? get locationInfo => _locationInfo;
  List<String> get topics => List.unmodifiable(_topics);

  // Event generator
  Event? getEvent() {
    if (_name != null &&
        _date != null &&
        _startingTime != null &&
        _locationInfo != null &&
        _topics.isNotEmpty &&
        _postedById != null &&
        _postedByName != null) {
      return Event(
          name: _name!,
          topics: _topics.toList(),
          locationInfo: _locationInfo!,
          subLocationInfo: subLocationInfo ?? '',
          description: description ?? _name!,
          dateTime: DateTime(_date!.year, _date!.month, _date!.day, _startingTime!.hour, _startingTime!.minute),
          postedByName: _postedByName!,
          postedById: _postedById!);
    }
    return null;
  }

  // Method to clear all event data
  void clear() {
    _name = null;
    _date = null;
    _startingTime = null;
    _locationInfo = null;
    subLocationInfo = null;
    _topics.clear();
    description = null;
    _postedById = null;
    _postedByName = null;
  }

  // methods to control two pages flow
  late final GlobalKey<FormState>? key;
  bool eventDetailsWidgetValidator() {
    if (key != null && key!.currentState != null && key!.currentState!.validate()) {
      return _name != null && _date != null && _startingTime != null && _locationInfo != null;
    }
    return false;
  }

  bool eventTopicsWidgetValidator() {
    return _topics.isNotEmpty;
  }
}
