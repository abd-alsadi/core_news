// ignore_for_file: camel_case_types

import 'dart:convert';

class JsonHelper {
  static String encode(Map<String, dynamic> data) {
    return json.encode(data);
  }

  static Map<String, dynamic> decode(String jsonStr) {
    return json.decode(jsonStr);
  }
}
