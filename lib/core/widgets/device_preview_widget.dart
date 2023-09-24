// ignore_for_file: prefer_function_declarations_over_variables

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';

DevicePreview devicePreviewWidget(page) {
  return DevicePreview(
    enabled: kDebugMode,
    builder: (context) => page, // Wrap your app
  );
}
