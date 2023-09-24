// ignore_for_file: must_be_immutable, constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core_news/configs/resources/app_colors.dart';
import 'package:core_news/configs/resources/app_strings.dart';
import 'package:core_news/core/helpers/launcher_helper.dart';
import 'package:core_news/core/utils/app_localizations.dart';
import 'package:core_news/features/news/domain/entities/news_entity.dart';
import 'package:flutter/material.dart';

class NewsDetailsPage extends StatelessWidget {
  static const String ROUTE_NAME = "news_details_page";

  NewsDetailsPage({super.key});
  late NewsEntity news;
  @override
  Widget build(BuildContext context) {
    news = ModalRoute.of(context)?.settings.arguments as NewsEntity;
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.grey[200],
            body: CustomScrollView(
              slivers: <Widget>[_buildAppbar(context), _buildBody(context)],
            )));
  }

  Widget _buildBody(context) {
    return SliverList(
        delegate: SliverChildListDelegate([
      Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            "${appLocalizations.trans(context, appStrings.NEWS_DETAILS_PUBLISHED_AT_KEY)} : ${news.publishedAt}",
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                        Text(
                            "${appLocalizations.trans(context, appStrings.NEWS_DETAILS_SOURCE_KEY)} : ${news.source}",
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                        Text(
                            "${appLocalizations.trans(context, appStrings.NEWS_DETAILS_AUTHOR_KEY)} : ${news.author}",
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ]),
                ),
              ),
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  news.title,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  news.description,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "${news.content}",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            (news.url.isEmpty
                ? const SizedBox()
                : Center(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor)),
                        onPressed: () async {
                          LauncherHelper.goUrl(news.url);
                        },
                        child: Text(
                          appLocalizations.trans(
                              context, appStrings.NEWS_DETAILS_GO_SOURCE_KEY),
                          style: const TextStyle(fontSize: 12),
                        )),
                  ))
          ],
        ),
      )
    ]));
  }

  Widget _buildAppbar(context) {
    return SliverAppBar(
      title: Text(
          appLocalizations.trans(context, appStrings.NEWS_DETAILS_TITLE_KEY)),
      expandedHeight: 250,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.all(20),
        title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(news.title, style: const TextStyle(fontSize: 16)),
            ]),
        background: Hero(
          tag: "HERO_NEWS_URL_${news.url}",
          child: CachedNetworkImage(
            height: 80,
            fit: BoxFit.fill,
            imageUrl: news.urlToImage ?? '',
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
                    child: CircularProgressIndicator(
                        color: appColors.progressColor,
                        value: downloadProgress.progress)),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
