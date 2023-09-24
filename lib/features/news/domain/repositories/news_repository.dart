import 'package:core_news/core/entities/app_result_entity.dart';
import 'package:core_news/core/errors/failures.dart';
import 'package:core_news/features/news/domain/entities/news_list_entity.dart';

abstract class INewsRepository {
  Future<AppResultEntity<Failure, NewsListEntity>> getNews(
      int page, int limit, String category);
  Future<AppResultEntity<Failure, NewsListEntity>> getNewsSearch(
      int page, int limit, String search);
}
