// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:core_news/configs/resources/app_strings.dart';
import 'package:core_news/core/entities/app_item_entity.dart';

class appThemes {
  static String DEFAULT_THEME = "basic";
  static List<AppItemEntity> getThemesList() {
    List<AppItemEntity> themes = [];
    themes.add(const AppItemEntity(
        code: "basic",
        nameResource: appStrings.THEME_BASIC_TITLE_KEY,
        descriptionResource: appStrings.THEME_BASIC_DESC_KEY));
    themes.add(const AppItemEntity(
        code: "red",
        nameResource: appStrings.THEME_RED_TITLE_KEY,
        descriptionResource: appStrings.THEME_RED_DESC_KEY));
    return themes;
  }
}
