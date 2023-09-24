// ignore_for_file: camel_case_types

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  SharedPreferences sharedPreferences;
  CacheHelper({required this.sharedPreferences});

  final String prefix = "##";

  Object get(String group, String key, Object defaultVal) {
    var myKey = '$group$prefix$key';
    var val = sharedPreferences.get(myKey);
    if (val == null) {
      return defaultVal;
    }
    return val;
  }

  Future<bool> add(String group, String key, Object value) {
    var myKey = '$group$prefix$key';
    var val = sharedPreferences.setString(myKey, value.toString());
    return val;
  }

  Future<bool> remove(String group, String key) {
    var myKey = '$group$prefix$key';
    var val = sharedPreferences.remove(myKey);
    return val;
  }

  Future<bool> clearAll() {
    var val = sharedPreferences.clear();
    return val;
  }

  Future<bool> clear(String group) {
    var keys = sharedPreferences.getKeys();
    var listKeys = keys.where((String key) => key.startsWith('$group$prefix'));
    listKeys.map((key) => remove(group, key));

    return Future.value(true);
  }
}
