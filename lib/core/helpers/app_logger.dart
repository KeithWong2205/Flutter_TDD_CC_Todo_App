import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class AppLogger {
  static void log(dynamic message) {
    var messageStr = _stringifyMessage(message);
    var time = DateFormat('HH:mm:ss').format(DateTime.now());
    var timeStr = time;
    if (!(kReleaseMode || kProfileMode)) {
      developer.log("$timeStr $messageStr");
    }
  }

  static String _stringifyMessage(dynamic message) {
    if (message is Map || message is Iterable) {
      var encoder = const JsonEncoder.withIndent(null);
      return encoder.convert(message);
    } else {
      return message.toString();
    }
  }
}
