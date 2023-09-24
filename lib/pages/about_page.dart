// ignore_for_file: constant_identifier_names

import 'package:core_news/configs/resources/app_icons.dart';
import 'package:core_news/configs/resources/app_strings.dart';
import 'package:core_news/core/utils/app_localizations.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names, must_be_immutable
class AboutPage extends StatelessWidget {
  static const String ROUTE_NAME = "about_page";

  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildeBody(context),
    );
  }

  AppBar _buildAppBar(context) {
    return AppBar(
        title: Text(
            appLocalizations.trans(context, appStrings.ABOUT_PAGE_TITLE_KEY)));
  }

  Widget _buildeBody(context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(appLocalizations.trans(context, appStrings.APP_NAME_KEY),
              style:
                  const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 20,
          ),
          Image(
            image: AssetImage(appIcons.ICON_APP),
            height: 100,
            width: 100,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(appLocalizations.trans(context, appStrings.APP_VERSION_KEY),
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 20,
          ),
          Text(appLocalizations.trans(context, appStrings.APP_CORY_KEY),
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 20,
          ),
          Text(appLocalizations.trans(context, appStrings.APP_DELEVOPED_BY_KEY),
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 20,
          ),
          Text(
              appLocalizations.trans(
                  context, appStrings.APP_DELEVOPED_MOBILE_KEY),
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      )),
    );
  }
}
