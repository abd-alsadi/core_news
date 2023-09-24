// ignore_for_file: constant_identifier_names

import 'package:core_news/core/utils/app_localizations.dart';
import 'package:core_news/features/news/presentation/bloc/news/news_bloc.dart';
import 'package:core_news/features/news/presentation/bloc/news/news_event.dart';
import 'package:core_news/features/news/presentation/bloc/news/news_state.dart';
import 'package:core_news/features/news/presentation/widgets/loading_widget.dart';
import 'package:core_news/features/news/presentation/widgets/message_widget.dart';
import 'package:core_news/features/news/presentation/widgets/news_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsPage extends StatefulWidget {
  static const String ROUTE_NAME = "news_page";
  final int currentTabIndex;
  final String currentTabKey;
  const NewsPage(
      {super.key, required this.currentTabIndex, required this.currentTabKey});

  @override
  State<StatefulWidget> createState() {
    return NewsPageState();
  }
}

class NewsPageState extends State<NewsPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  Future<void> onLoadMoreCallback(
      context, ScrollController scrollController) async {
    var bloc = BlocProvider.of<NewsBloc>(context);
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !bloc.isLoading) {
      var tabIndex = widget.currentTabIndex;
      bloc.add(GetNewsWithPage(
        categoryIndex: tabIndex,
        categoryName: widget.currentTabKey,
      ));
    }
  }

  Future<void> onRefreshCallback(context) async {
    var tabIndex = widget.currentTabIndex;
    BlocProvider.of<NewsBloc>(context).add(
        GetNews(categoryIndex: tabIndex, categoryName: widget.currentTabKey));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocConsumer<NewsBloc, NewsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadingNewsState) {
              return const LoadingWidget();
            } else if (state is LoadedNewsState) {
              return NewsListWidget(
                news: state.news,
                onRefreshCallback: onRefreshCallback,
                onLoadMoreCallback: onLoadMoreCallback,
              );
            } else if (state is TempNewsState) {
              return NewsListWidget(
                  news: state.news,
                  onRefreshCallback: onRefreshCallback,
                  onLoadMoreCallback: onLoadMoreCallback);
            } else if (state is ErrorNewsState) {
              return MessageWidget(
                  message: appLocalizations.trans(context, state.message));
            }

            return const LoadingWidget();
          }),
    );
  }
}
