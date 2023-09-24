// ignore_for_file: constant_identifier_names

import 'package:core_news/configs/resources/app_strings.dart';
import 'package:core_news/configs/resources/app_themes.dart';
import 'package:core_news/core/utils/app_localizations.dart';
import 'package:core_news/features/theme/domain/entities/theme_entity.dart';
import 'package:core_news/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:core_news/features/theme/presentation/bloc/theme_state.dart';
import 'package:core_news/features/theme/presentation/widgets/theme_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemesPage extends StatelessWidget {
  static const String ROUTE_NAME = "themes_page";
  const ThemesPage({super.key});

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
            appLocalizations.trans(context, appStrings.THEMES_PAGE_TITLE_KEY)));
  }

  Widget _buildeBody(BuildContext context) {
    var themesList = appThemes.getThemesList();
    return Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<ThemeBloc, ThemeState>(
            listener: (context, state) {},
            builder: (context, state) {
              var currentTheme =
                  "basic"; //appLocalizations.getCurrentLang(context);
              if (state is LoadedThemeState) {
                currentTheme = state.theme;
              }

              return ListView.separated(
                  itemCount: themesList.length,
                  itemBuilder: (context, index) {
                    var themeEntity = themesList[index];
                    var theme = ThemeEntity(
                        code: themeEntity.code,
                        nameResource: themeEntity.nameResource,
                        descriptionResource: themeEntity.descriptionResource);
                    return ThemeItemWidget(
                      theme: theme,
                      currentTheme: currentTheme,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  });
            }));
  }
}
