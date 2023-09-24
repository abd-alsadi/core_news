// ignore_for_file: constant_identifier_names

import 'package:core_news/configs/resources/app_langs.dart';
import 'package:core_news/configs/resources/app_strings.dart';
import 'package:core_news/core/utils/app_localizations.dart';
import 'package:core_news/features/lang/domain/entities/lang_entity.dart';
import 'package:core_news/features/lang/presentation/bloc/lang_bloc.dart';
import 'package:core_news/features/lang/presentation/bloc/lang_state.dart';
import 'package:core_news/features/lang/presentation/widgets/lang_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LangsPage extends StatelessWidget {
  static const String ROUTE_NAME = "langs_page";

  const LangsPage({super.key});

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
            appLocalizations.trans(context, appStrings.LANGS_PAGE_TITLE_KEY)));
  }

  Widget _buildeBody(BuildContext context) {
    var langsList = appLangs.getLangsList();
    return Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<LangBloc, LangState>(
            listener: (context, state) {},
            builder: (context, state) {
              var currentLang = appLocalizations.getCurrentLang(context);
              if (state is LoadedLangState) {
                currentLang = state.lang;
              }

              return ListView.separated(
                  itemCount: langsList.length,
                  itemBuilder: (context, index) {
                    var langEntity = langsList[index];
                    var lang = LangEntity(
                        code: langEntity.code,
                        nameResource: langEntity.nameResource,
                        descriptionResource: langEntity.descriptionResource);
                    return LangItemWidget(
                      lang: lang,
                      currentLang: currentLang,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  });
            }));
  }
}
