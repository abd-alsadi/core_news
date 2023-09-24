// ignore_for_file: constant_identifier_names

import 'package:core_news/configs/data/news_data.dart';
import 'package:core_news/configs/resources/app_colors.dart';
import 'package:core_news/configs/resources/app_icons.dart';
import 'package:core_news/configs/resources/app_strings.dart';
import 'package:core_news/core/helpers/navigation_helper.dart';
import 'package:core_news/core/helpers/popup_helper.dart';
import 'package:core_news/core/utils/app_localizations.dart';
import 'package:core_news/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:core_news/features/auth/presentation/bloc/auth_event.dart';
import 'package:core_news/features/lang/presentation/pages/langs_page.dart';
import 'package:core_news/features/news/core/constants/enums_constant.dart';
import 'package:core_news/features/news/presentation/bloc/news/news_bloc.dart';
import 'package:core_news/features/news/presentation/bloc/news/news_event.dart';
import 'package:core_news/features/theme/presentation/pages/themes_page.dart';
import 'package:core_news/pages/about_page.dart';
import 'package:core_news/features/news/presentation/pages/news_page.dart';
import 'package:core_news/features/news/presentation/pages/news_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static const String ROUTE_NAME = "home_page";
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabsController;
  Map<String, String> tabs = getCategories();
  void onChangeTab() {
    var tabIndex = tabsController.index;
    BlocProvider.of<NewsBloc>(context).add(GetNewsByTabCached(
        categoryIndex: tabIndex, categoryName: tabs.keys.toList()[tabIndex]));
  }

  @override
  void initState() {
    tabsController = TabController(length: tabs.keys.length, vsync: this);
    tabsController.addListener(onChangeTab);
    super.initState();
  }

  @override
  void dispose() {
    tabsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: _buildAppbar(context),
      drawer: _buildDrawer(context),
      body: _buildeBody(context),
      floatingActionButton: _buildFoatingButton(context),
    );
  }

  Widget _buildLogoutOptions(context) {
    List<Widget> options = [];
    var title = appLocalizations.trans(context, appStrings.CONFIRM_MESSAGE_KEY);
    options.add(Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ));
    options.add(ListTile(
      title: Text(appLocalizations.trans(context, appStrings.OK_KEY)),
      onTap: () {
        BlocProvider.of<AuthBloc>(context).add(const LogoutEvent());
      },
    ));
    options.add(ListTile(
      title: Text(appLocalizations.trans(context, appStrings.CANCEL_KEY)),
      onTap: () {
        Navigator.of(context).pop();
      },
    ));
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: options,
    ));
  }

  void onLogoutClick(context) {
    var options = _buildLogoutOptions(context);
    PopupHelper.showBottomDialogMessage(context, options, 200);
  }

  void onDrawerItemClick(
      context, DrawerItemsActionEnum action, withCloseDrawer) {
    if (withCloseDrawer) {
      Navigator.of(context).pop(); //close drawer
    }

    switch (action) {
      case DrawerItemsActionEnum.LOGOUT_ACTION:
        onLogoutClick(context);
        break;
      case DrawerItemsActionEnum.APP_LANGUAGE_ACTION:
        NavigationHelper.showRoute(context, LangsPage.ROUTE_NAME, null);
        break;
      case DrawerItemsActionEnum.ABOUT_ACTION:
        NavigationHelper.showRoute(context, AboutPage.ROUTE_NAME, null);
        break;
      case DrawerItemsActionEnum.APP_THEME_ACTION:
        NavigationHelper.showRoute(context, ThemesPage.ROUTE_NAME, null);
        break;

      default:
        break;
    }
  }

  Drawer _buildDrawer(context) {
    return Drawer(
        backgroundColor: Colors.white,
        child: ListView(children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Image(
                      image: AssetImage(appIcons.ICON_APP),
                      width: 80,
                      height: 80,
                      fit: BoxFit.fill),
                  const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Adminstrator user',
                        style: TextStyle(color: Colors.white),
                      ))
                ])),
          ),
          // ListTile(
          //   title: Text(appLocalizations.trans(
          //       context, appStrings.ACCOUNTS_TAB_TITLE_KEY)),
          //   subtitle: Text(appLocalizations.trans(
          //       context, appStrings.ACCOUNTS_TAB_DESC_KEY)),
          //   leading: const Icon(Icons.account_circle),
          //   onTap: () {
          //     onDrawerItemClick(context, DrawerItemsActionEnum.ACCOUNTS_ACTION);
          //   },
          // ),
          // ListTile(
          //   title: Text(appLocalizations.trans(
          //       context, appStrings.PRIVACY_TAB_TITLE_KEY)),
          //   subtitle: Text(appLocalizations.trans(
          //       context, appStrings.PRIVACY_TAB_DESC_KEY)),
          //   leading: const Icon(Icons.privacy_tip_rounded),
          //   onTap: () {
          //     onDrawerItemClick(context, DrawerItemsActionEnum.PRIVACY_ACTION);
          //   },
          // ),
          // ListTile(
          //   title: Text(appLocalizations.trans(
          //       context, appStrings.NOTIFICATIONS_TAB_TITLE_KEY)),
          //   subtitle: Text(appLocalizations.trans(
          //       context, appStrings.NOTIFICATIONS_TAB_DESC_KEY)),
          //   leading: const Icon(Icons.settings),
          //   onTap: () {
          //     onDrawerItemClick(
          //         context, DrawerItemsActionEnum.NOTIFICATIONS_ACTION);
          //   },
          // ),
          // ListTile(
          //   title: Text(appLocalizations.trans(
          //       context, appStrings.STORAGE_DATA_TITLE_KEY)),
          //   subtitle: Text(appLocalizations.trans(
          //       context, appStrings.STORAGE_DATA_DESC_KEY)),
          //   leading: const Icon(Icons.star),
          //   onTap: () {
          //     onDrawerItemClick(
          //         context, DrawerItemsActionEnum.STORAGE_DATA_ACTION);
          //   },
          // ),
          ListTile(
            title: Text(appLocalizations.trans(
                context, appStrings.APP_LANGUAGE_TAB_TITLE_KEY)),
            subtitle: Text(appLocalizations.trans(
                context, appStrings.APP_LANGUAGE_TAB_DESC_KEY)),
            leading: const Icon(Icons.language),
            onTap: () {
              onDrawerItemClick(
                  context, DrawerItemsActionEnum.APP_LANGUAGE_ACTION, true);
            },
          ),
          ListTile(
            title: Text(appLocalizations.trans(
                context, appStrings.APP_THEME_TAB_TITLE_KEY)),
            subtitle: Text(appLocalizations.trans(
                context, appStrings.APP_THEME_TAB_DESC_KEY)),
            leading: const Icon(Icons.theater_comedy),
            onTap: () {
              onDrawerItemClick(
                  context, DrawerItemsActionEnum.APP_THEME_ACTION, true);
            },
          ),
          ListTile(
            title: Text(appLocalizations.trans(
                context, appStrings.LOGOUT_TAB_TITLE_KEY)),
            subtitle: Text(appLocalizations.trans(
                context, appStrings.LOGOUT_TAB_DESC_KEY)),
            leading: const Icon(Icons.logout),
            onTap: () {
              onDrawerItemClick(
                  context, DrawerItemsActionEnum.LOGOUT_ACTION, true);
            },
          ),
          ListTile(
            title: Text(appLocalizations.trans(
                context, appStrings.ABOUT_TAB_TITLE_KEY)),
            subtitle: Text(
                appLocalizations.trans(context, appStrings.ABOUT_TAB_DESC_KEY)),
            leading: const Icon(Icons.info),
            onTap: () {
              onDrawerItemClick(
                  context, DrawerItemsActionEnum.ABOUT_ACTION, true);
            },
          ),
        ]));
  }

  FloatingActionButton _buildFoatingButton(context) {
    return FloatingActionButton(
        backgroundColor: appColors.floatingbuttonColor,
        child: const Icon(Icons.logout),
        onPressed: () {
          // if (BlocProvider.of<NewsBloc>(context).isLoading == false) {
          // onRefreshCallback(context);
          onLogoutClick(context);
          //  }
        });
  }

  Widget _buildeBody(context) {
    var currentCategory = tabs.keys.toList()[tabsController.index];
    return NewsPage(
        currentTabIndex: tabsController.index, currentTabKey: currentCategory);
  }

  AppBar _buildAppbar(context) {
    List<PopupMenuEntry<dynamic>> moreActionsList = [];
    moreActionsList.add(PopupMenuItem(
        value: DrawerItemsActionEnum.LOGOUT_ACTION,
        child: Text(
            appLocalizations.trans(context, appStrings.LOGOUT_TAB_TITLE_KEY))));

    return AppBar(
      title: Text(appLocalizations.trans(context, appStrings.APP_NAME_KEY)),
      centerTitle: false,
      actions: [
        Padding(
            padding: const EdgeInsets.only(left: 2, right: 2),
            child: IconButton(
                onPressed: () {
                  NavigationHelper.showRoute(
                      context, NewsSearchPage.ROUTE_NAME, null);
                },
                icon: const Icon(Icons.search))),
        Padding(
            padding: const EdgeInsets.only(left: 2, right: 2),
            child: PopupMenuButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onCanceled: null,
              onSelected: (val) {
                onDrawerItemClick(context, val, false);
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) {
                return moreActionsList.toList();
              },
            )),
      ],
      bottom: TabBar(
        // labelPadding: const EdgeInsets.only(left: 5, right: 5),
        // tabAlignment: TabAlignment.center,
        // splashBorderRadius: BorderRadius.circular(10),
        // indicatorPadding: const EdgeInsets.only(left: 5, right: 5),
        // dividerColor: Colors.red,
        controller: tabsController,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: Colors.white,
        indicatorWeight: 3,
        isScrollable: true,
        labelColor: Colors.white,
        tabs: List.generate(tabs.length, (index) {
          return Tab(
            child: Text(
              appLocalizations.trans(context, tabs.values.toList()[index]),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          );
        }).toList(),
      ),
    );
  }
}
