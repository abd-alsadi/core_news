// ignore_for_file: file_names, camel_case_types

import 'dart:convert';

import 'package:core_news/configs/resources/app_langs.dart';
import 'package:core_news/core/constants/cache_constant.dart';
import 'package:core_news/core/entities/app_item_entity.dart';
import 'package:core_news/core/helpers/cache_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class appLocalizations {
  late Locale locale;

  appLocalizations(localeParam) {
    locale = localeParam;
  }

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static appLocalizations? of(BuildContext context) {
    return Localizations.of<appLocalizations>(context, appLocalizations);
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<appLocalizations> delegate =
      _appLocalizationsDelegate();

  late Map<String, String> _localizedStrings;

  Future<bool> load() async {
    // Load the language JSON file from the "lang" folder
    // String jsonString = await rootBundle.loadString(
    //     'assets/langs/${locale.languageCode}-${locale.countryCode}-${locale.countryCode}.json');
    String jsonString =
        await rootBundle.loadString('assets/langs/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  // This method will be called from every widget which needs a localized text
  String translate(String key) {
    return _localizedStrings[key] ?? "";
  }

  static List<AppItemEntity> getSupportedLangs() {
    return appLangs.getLangsList();
  }

  static String getCurrentLang(context) {
    return appLocalizations.of(context)!.locale.languageCode;
  }

  static String getDefaultLang() {
    return appLangs.DEFAULT_LANG;
  }

  static String trans(context, key) {
    return appLocalizations.of(context)!.translate(key);
  }

  static String getCurrentLangFromCache(sharedPreferences) {
    var langValue = CacheHelper(sharedPreferences: sharedPreferences)
        .get(cacheGroupsConstant.CACHED_GROUP_LANG_KEY,
            cacheGroupsConstant.CACHED_GROUP_LANG_KEY, getDefaultLang())
        .toString();
    return langValue;
  }

  static List<Locale> getSupportedLocales() {
    var langs = appLocalizations.getSupportedLangs();
    return List<Locale>.generate(langs.length, (index) {
      var key = langs[index].code;
      return Locale(key);
    });
  }
}

class _appLocalizationsDelegate
    extends LocalizationsDelegate<appLocalizations> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _appLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    var langs = appLocalizations.getSupportedLangs();
    var isFound = false;
    for (var lang in langs) {
      if (locale.languageCode == lang.code) {
        isFound = true;
        break;
      }
    }
    // Include all of your supported language codes here
    return isFound;
  }

  @override
  Future<appLocalizations> load(Locale locale) async {
    // appLocalizations class is where the JSON loading actually runs
    appLocalizations localizations = appLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_appLocalizationsDelegate old) => false;
}
