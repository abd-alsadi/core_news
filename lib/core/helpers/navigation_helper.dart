// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class NavigationHelper {
  static void showPage(context, page, args) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => page, settings: args));
  }

  static void showRoute(context, route, args) {
    Navigator.pushNamed(context, route, arguments: args);
  }

  static void replacePage(context, page, args) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page, settings: args));
  }

  static void replaceRoute(context, route, args) {
    Navigator.pushReplacementNamed(context, route, arguments: args);
  }
}
