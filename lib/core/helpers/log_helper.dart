// ignore_for_file: camel_case_types

import 'package:flutter/foundation.dart';

class LogHelper {
  static void printConsole(message) {
    if (kDebugMode) {
      print(message);
    }
  }
}
