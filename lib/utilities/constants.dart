import 'package:flutter/material.dart';

import '../models/event_request_states.dart';

class AppColors {
  static const kDarkGreen = Color(0xff31572c);
  static const kForestGreen = Color(0xff4f772d);
  static const kFernGreen = Color(0xff90a955);
  static const kPaleGoldenrod = Color(0xffecf39e);
  static const kBackground = Color(0xffffffff);
  static const kHintTextColor = Color(0xffA9A9A9);
  static const kPlaceHolderGrey = Color(0xFFA9A9A9);

  static Color getColorForState(EventRequestState state) {
    switch (state) {
      case EventRequestState.pending:
        return Colors.orangeAccent;
      case EventRequestState.accepted:
        return Colors.green;
      case EventRequestState.rejected:
        return Colors.redAccent;
      case EventRequestState.cancelled:
        return Colors.grey;
    }
  }
}
