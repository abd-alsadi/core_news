import 'package:core_news/features/news/data/models/news_model.dart';
import 'package:core_news/features/news/domain/entities/news_entity.dart';
import 'package:core_news/features/news/domain/entities/news_list_entity.dart';

// ignore: must_be_immutable
class NewsListModel extends NewsListEntity {
  NewsListModel({
    required super.news,
    required super.hasMore,
  });

  factory NewsListModel.fromJsonRequest(Map<String, dynamic> json, int? count) {
    final List decodedJsonList = json['articles'];
    final int total = json['totalResults'];
    bool hasMore = false;
    if (count != null) {
      if (total > count) {
        hasMore = true;
      }
    }
    List<NewsModel> news = decodedJsonList
        .map<NewsModel>((jsonNews) => NewsModel.fromJson(jsonNews, true))
        .toList();
    var model = NewsListModel(
      news: news,
      hasMore: hasMore,
    );

    return model;
  }
  factory NewsListModel.fromJson(Map<String, dynamic> json) {
    final List newsList = json['news'];
    final bool hasMore = json['hasMore'];
    List<NewsModel> news = newsList
        .map<NewsModel>((jsonNews) => NewsModel.fromJson(jsonNews, false))
        .toList();
    var model = NewsListModel(
      news: news,
      hasMore: hasMore,
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    return {
      'hasMore': hasMore,
      'news': news
          .map((NewsEntity e) => NewsModel(
                  description: e.description,
                  publishedAt: e.publishedAt,
                  title: e.title,
                  url: e.url,
                  author: e.author,
                  content: e.content,
                  source: e.source,
                  urlToImage: e.urlToImage)
              .toJson())
          .toList()
    };
  }
}
