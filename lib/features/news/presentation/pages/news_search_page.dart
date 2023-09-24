// ignore_for_file: constant_identifier_names

import 'package:core_news/configs/resources/app_icons.dart';
import 'package:core_news/configs/resources/app_strings.dart';
import 'package:core_news/core/utils/app_localizations.dart';
import 'package:core_news/features/news/presentation/bloc/news_search/news_search_bloc.dart';
import 'package:core_news/features/news/presentation/bloc/news_search/news_search_event.dart';
import 'package:core_news/features/news/presentation/bloc/news_search/news_search_state.dart';
import 'package:core_news/features/news/presentation/widgets/loading_widget.dart';
import 'package:core_news/features/news/presentation/widgets/message_widget.dart';
import 'package:core_news/features/news/presentation/widgets/news_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsSearchPage extends StatefulWidget {
  static const String ROUTE_NAME = "news_search_page";

  const NewsSearchPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return NewsSearchPageState();
  }
}

// ignore: non_constant_identifier_names, must_be_immutable
class NewsSearchPageState extends State<NewsSearchPage> {
  var queryController = TextEditingController();
  void onSearch() {
    var query = queryController.text;
    BlocProvider.of<NewsSearchBloc>(context).add(GetNewsSearch(query: query));
  }

  void onClearSearch() {
    queryController.text = "";
    setState(() {});
  }

  @override
  void initState() {
    BlocProvider.of<NewsSearchBloc>(context).add(const GetNewsSearchInit());
    super.initState();
  }

  @override
  void dispose() {
    queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildeBody(context),
    );
  }

  AppBar _buildAppBar(context) {
    return AppBar(
      title: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextField(
          autofocus: true,
          onSubmitted: (val) {
            onSearch();
          },
          controller: queryController,
          onChanged: (val) {
            setState(() {});
          },
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              // prefixIcon: IconButton(
              //   icon: const Icon(Icons.search),
              //   onPressed: onSearch,
              // ),
              suffixIcon: (queryController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: onClearSearch,
                    )
                  : const SizedBox()),
              hintText: appLocalizations.trans(context, appStrings.SEARCH_KEY),
              border: InputBorder.none),
        ),
      ),
    );
  }

  Future<void> onLoadMoreCallback(
      context, ScrollController scrollController) async {
    var bloc = BlocProvider.of<NewsSearchBloc>(context);
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !bloc.isLoading) {
      var query = queryController.text;
      bloc.add(GetNewsSearchWithPage(query: query));
    }
  }

  Future<void> onRefreshCallback(context) async {
    var query = queryController.text;
    BlocProvider.of<NewsSearchBloc>(context).add(GetNewsSearch(query: query));
  }

  Widget _buildeBody(context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocConsumer<NewsSearchBloc, NewsSearchState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is NewsSearchStateInitial) {
              return Center(
                  child: Image(
                      image: AssetImage(appIcons.ICON_APP),
                      height: 100,
                      width: 100,
                      fit: BoxFit.fill));
            } else if (state is LoadingNewsSearchState) {
              return const LoadingWidget();
            } else if (state is LoadedNewsSearchState) {
              return NewsListWidget(
                  news: state.news,
                  onLoadMoreCallback: onLoadMoreCallback,
                  onRefreshCallback: onRefreshCallback);
            } else if (state is TempNewsSearchState) {
              return NewsListWidget(
                  news: state.news,
                  onLoadMoreCallback: onLoadMoreCallback,
                  onRefreshCallback: onRefreshCallback);
            } else if (state is ErrorNewsSearchState) {
              return MessageWidget(
                  message: appLocalizations.trans(context, state.message));
            }

            return const LoadingWidget();
          }),
    );
  }
}
