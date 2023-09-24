import 'package:core_news/configs/resources/app_colors.dart';
import 'package:core_news/features/news/domain/entities/news_list_entity.dart';
import 'package:core_news/features/news/presentation/widgets/news_item_widget.dart';
import 'package:flutter/material.dart';

class NewsListWidget extends StatefulWidget {
  final NewsListEntity news;
  final Function onRefreshCallback;
  final Function onLoadMoreCallback;
  const NewsListWidget(
      {super.key,
      required this.news,
      required this.onRefreshCallback,
      required this.onLoadMoreCallback});

  @override
  State<StatefulWidget> createState() {
    return NewsListWidgetState();
  }
}

class NewsListWidgetState extends State<NewsListWidget> {
  late ScrollController scrollController;

  @override
  initState() {
    super.initState();
    scrollController = ScrollController(initialScrollOffset: 0);

    scrollController.addListener(loadMoreDataListViewListener);
  }

  @override
  dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        displacement: 50,
        onRefresh: () async {
          onRefresh(context);
        },
        child: ListView.builder(
          controller: scrollController,
          itemCount: (widget.news.hasMore
              ? widget.news.news.length + 1
              : widget.news.news.length),
          itemBuilder: (context, index) {
            if (index < widget.news.news.length) {
              return NewsItemWidget(
                  index: index, item: widget.news.news[index]);
            }
            return const Center(
                child: CircularProgressIndicator(
              color: appColors.progressColor,
            ));
          },
        ));
  }

  Future<void> loadMoreDataListViewListener() async {
    await widget.onLoadMoreCallback(context, scrollController);
  }

  Future<void> onRefresh(context) async {
    await widget.onRefreshCallback(context);
  }
}
