import 'package:core_news/configs/resources/app_colors.dart';
import 'package:core_news/core/utils/app_localizations.dart';
import 'package:core_news/features/theme/domain/entities/theme_entity.dart';
import 'package:core_news/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:core_news/features/theme/presentation/bloc/theme_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeItemWidget extends StatelessWidget {
  final ThemeEntity theme;
  final String currentTheme;
  const ThemeItemWidget(
      {super.key, required this.theme, required this.currentTheme});

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      contentPadding: const EdgeInsets.all(0),
      activeColor: Theme.of(context).primaryColor,
      title: Text(appLocalizations.trans(context, theme.nameResource)),
      subtitle:
          Text(appLocalizations.trans(context, theme.descriptionResource)),
      onChanged: (val) {
        BlocProvider.of<ThemeBloc>(context)
            .add(ChangeThemeEvent(theme: theme.code));
      },
      value: theme.code,
      groupValue: currentTheme,
    );
  }
}
