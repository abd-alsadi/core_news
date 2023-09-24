import 'package:core_news/configs/resources/app_colors.dart';
import 'package:flutter/material.dart';

final appTheme = ThemeData(
    appBarTheme: const AppBarTheme(
  backgroundColor: appColors.primary,
  centerTitle: false,
));

final appRedTheme = ThemeData(
    primaryColor: appColors.red,
    appBarTheme: const AppBarTheme(
      backgroundColor: appColors.red,
      centerTitle: false,
    ));

ThemeData getTheme(code) {
  if (code == "red") {
    return appRedTheme;
  }
  return appTheme;
}
