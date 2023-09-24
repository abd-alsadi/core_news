// ignore_for_file: library_prefixes, depend_on_referenced_packages

import 'package:core_news/configs/data/news_data.dart';
import 'package:core_news/configs/resources/app_strings.dart';
import 'package:core_news/configs/routes/app_routes.dart';
import 'package:core_news/configs/themes/app_theme.dart';
import 'package:core_news/core/constants/cache_constant.dart';
import 'package:core_news/core/helpers/auth_helper.dart';
import 'package:core_news/core/helpers/cache_helper.dart';
import 'package:core_news/core/utils/app_localizations.dart';
import 'package:core_news/features/auth/domain/entities/auth_entity.dart';
import 'package:core_news/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:core_news/features/auth/presentation/bloc/auth_event.dart';
import 'package:core_news/features/auth/presentation/bloc/auth_state.dart';
import 'package:core_news/features/auth/presentation/pages/login_page.dart';
import 'package:core_news/features/lang/presentation/bloc/lang_bloc.dart';
import 'package:core_news/features/lang/presentation/bloc/lang_state.dart';
import 'package:core_news/features/news/presentation/bloc/news/news_bloc.dart';
import 'package:core_news/features/news/presentation/bloc/news/news_event.dart';
import 'package:core_news/features/news/presentation/bloc/news_search/news_search_bloc.dart';
import 'package:core_news/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:core_news/features/theme/presentation/bloc/theme_state.dart';
import 'package:core_news/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../injection/injetion_container.dart' as DI;

class AppPage extends StatefulWidget {
  const AppPage({super.key, required this.sharedPreferences});
  final SharedPreferences sharedPreferences;
  @override
  State<StatefulWidget> createState() {
    return AppPageState();
  }
}

class AppPageState extends State<AppPage> {
  @override
  Widget build(BuildContext context) {
    var authEntity =
        AuthHelper(sharedPreferences: widget.sharedPreferences).getAuth();
    AuthEntity? auth;
    if (authEntity != null) {
      auth = AuthEntity(
          userName: authEntity.userName,
          password: authEntity.password,
          token: authEntity.token);
    }
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
              create: (context) =>
                  DI.sl<AuthBloc>()..add(AuthInitEvent(auth: auth))),
        ],
        child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is SuccessLoginState) {
                return renderHomePage(context);
              } else if (state is SuccesLogoutState) {
                return renderLoginPage(context);
              }
              if (auth == null) {
                return renderLoginPage(context);
              }
              return renderHomePage(context);
            }));
  }

  Widget renderLoginPage(context) {
    return MultiBlocProvider(providers: [
      BlocProvider<LangBloc>(create: (context) => DI.sl<LangBloc>()),
      BlocProvider<ThemeBloc>(create: (context) => DI.sl<ThemeBloc>())
    ], child: renderMaterialApp(context, const LoginPage()));
  }

  Widget renderHomePage(context) {
    var cats = getCategories();

    return MultiBlocProvider(providers: [
      BlocProvider<NewsBloc>(
          create: (context) => DI.sl<NewsBloc>()
            ..add(GetNews(
                categoryIndex: 0, categoryName: cats.keys.toList()[0]))),
      BlocProvider<NewsSearchBloc>(
          create: (context) => DI.sl<NewsSearchBloc>()),
      BlocProvider<LangBloc>(create: (context) => DI.sl<LangBloc>()),
      BlocProvider<ThemeBloc>(create: (context) => DI.sl<ThemeBloc>())
    ], child: renderMaterialApp(context, const HomePage()));
  }

  Widget renderMaterialApp(context, page) {
    return BlocConsumer<LangBloc, LangState>(
        listener: (context, langState) {},
        builder: (context, langState) {
          String defaultLang = appLocalizations.getDefaultLang();
          var lang = CacheHelper(sharedPreferences: widget.sharedPreferences)
              .get(cacheGroupsConstant.CACHED_GROUP_LANG_KEY,
                  cacheGroupsConstant.CACHED_GROUP_LANG_KEY, defaultLang)
              .toString();
          var theme = CacheHelper(sharedPreferences: widget.sharedPreferences)
              .get(cacheGroupsConstant.CACHED_GROUP_THEME_KEY,
                  cacheGroupsConstant.CACHED_GROUP_THEME_KEY, ""); //

          if (langState is LoadedLangState) {
            lang = langState.lang;
          }
          print('lang is $lang');
          return BlocConsumer<ThemeBloc, ThemeState>(
            listener: (context, themeState) {},
            builder: (context, themeState) {
              appLocalizations.getDefaultLang();
              if (themeState is LoadedThemeState) {
                theme = themeState.theme;
              }
              print('theme is $theme');

              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: appStrings.APP_NAME_KEY,
                theme: getTheme(theme),
                routes: appRoutes,
                supportedLocales: appLocalizations.getSupportedLocales(),
                locale: Locale(lang),
                localizationsDelegates: const [
                  appLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                localeListResolutionCallback: (locales, supportedLocales) {
                  for (Locale locale in locales!) {
                    // if device language is supported by the app,
                    // just return it to set it as current app language
                    if (supportedLocales.contains(locale)) {
                      return locale;
                    }
                  }

                  // if device language is not supported by the app,
                  // the app will set it to english but return this to set to Bahasa instead
                  return Locale(appLocalizations.getDefaultLang());
                },
                home: page,
              );
            },
          );
        });
  }
}
