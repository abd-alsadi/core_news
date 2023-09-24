// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:core_news/configs/resources/app_strings.dart';
import 'package:core_news/core/entities/app_item_entity.dart';

class appLangs {
  static String DEFAULT_LANG = "en";
  static List<AppItemEntity> getLangsList() {
    List<AppItemEntity> langs = [];
    langs.add(const AppItemEntity(
        code: "en",
        nameResource: appStrings.ENGLISH_TITLE_KEY,
        descriptionResource: appStrings.ENGLISH_DESC_KEY));
    langs.add(const AppItemEntity(
        code: "ar",
        nameResource: appStrings.ARABIC_TITLE_KEY,
        descriptionResource: appStrings.ARABIC_DESC_KEY));
    return langs;
  }
}
