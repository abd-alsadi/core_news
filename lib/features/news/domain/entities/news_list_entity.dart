import 'package:core_news/features/news/domain/entities/news_entity.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class NewsListEntity extends Equatable {
  List<NewsEntity> news;
  bool hasMore;

  //constructor
  NewsListEntity({
    required this.news,
    required this.hasMore,
  });

  //hash code for equality
  @override
  List<Object?> get props => [
        news,
        hasMore,
      ];
  NewsListEntity clone() {
    List<NewsEntity> newList = news
        .map((e) => NewsEntity(
            title: e.title,
            description: e.description,
            publishedAt: e.publishedAt,
            url: e.url,
            author: e.author,
            content: e.content,
            source: e.source,
            urlToImage: e.urlToImage))
        .toList();
    return NewsListEntity(news: newList, hasMore: hasMore);
  }
}
