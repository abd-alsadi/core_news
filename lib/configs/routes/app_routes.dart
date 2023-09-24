// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names

import 'package:core_news/features/lang/presentation/pages/langs_page.dart';
import 'package:core_news/features/theme/presentation/pages/themes_page.dart';
import 'package:core_news/pages/about_page.dart';
import 'package:core_news/features/news/presentation/pages/news_details_page.dart';
import 'package:core_news/features/news/presentation/pages/news_page.dart';
import 'package:core_news/features/news/presentation/pages/news_search_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> appRoutes = {
  NewsPage.ROUTE_NAME: (context) =>
      const NewsPage(currentTabIndex: 0, currentTabKey: ""),
  NewsSearchPage.ROUTE_NAME: (context) => const NewsSearchPage(),
  NewsDetailsPage.ROUTE_NAME: (context) => NewsDetailsPage(),
  LangsPage.ROUTE_NAME: (context) => const LangsPage(),
  ThemesPage.ROUTE_NAME: (context) => const ThemesPage(),
  AboutPage.ROUTE_NAME: (context) => const AboutPage(),
};
