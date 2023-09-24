import 'package:core_news/configs/resources/app_colors.dart';
import 'package:core_news/core/utils/app_localizations.dart';
import 'package:core_news/features/lang/domain/entities/lang_entity.dart';
import 'package:core_news/features/lang/presentation/bloc/lang_bloc.dart';
import 'package:core_news/features/lang/presentation/bloc/lang_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LangItemWidget extends StatelessWidget {
  final LangEntity lang;
  final String currentLang;
  const LangItemWidget(
      {super.key, required this.lang, required this.currentLang});

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      contentPadding: const EdgeInsets.all(0),
      activeColor: Theme.of(context).primaryColor,
      title: Text(appLocalizations.trans(context, lang.nameResource)),
      subtitle: Text(appLocalizations.trans(context, lang.descriptionResource)),
      onChanged: (val) {
        BlocProvider.of<LangBloc>(context)
            .add(ChangeLangEvent(lang: lang.code));
      },
      value: lang.code,
      groupValue: currentLang,
    );
  }
}
