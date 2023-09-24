import 'package:cached_network_image/cached_network_image.dart';
import 'package:core_news/configs/resources/app_colors.dart';
import 'package:core_news/core/helpers/navigation_helper.dart';
import 'package:core_news/features/news/domain/entities/news_entity.dart';
import 'package:core_news/features/news/presentation/pages/news_details_page.dart';
import 'package:flutter/material.dart';

class NewsItemWidget extends StatelessWidget {
  final NewsEntity item;
  final int index;
  const NewsItemWidget({super.key, required this.index, required this.item});

  void onCardClick(context) {
    NavigationHelper.showRoute(context, NewsDetailsPage.ROUTE_NAME, item);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onCardClick(context);
        },
        child: Card(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [_buildThumbnail(), _buildContent()])));
  }

  Widget _buildContent() {
    return Expanded(
        flex: 3,
        child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.title,
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(item.description,
                    maxLines: 4, style: const TextStyle(fontSize: 12)),
              ],
            )));
  }

  Widget _buildThumbnail() {
    return Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Hero(
            tag: "HERO_NEWS_URL_${item.url}",
            child: CachedNetworkImage(
              height: 80,
              fit: BoxFit.fill,
              imageUrl: item.urlToImage ?? '',
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                      child: CircularProgressIndicator(
                          color: appColors.progressColor,
                          value: downloadProgress.progress)),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ));
  }
}
