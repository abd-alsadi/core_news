import 'package:core_news/core/constants/cache_constant.dart';
import 'package:core_news/core/errors/exceptions.dart';
import 'package:core_news/core/helpers/cache_helper.dart';
import 'package:core_news/core/helpers/json_helper.dart';
import 'package:core_news/features/news/data/models/news_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class INewsLocalDataSource {
  Future<NewsListModel> getNewsFromCache(int page, int limit, String category);
  Future<bool> addNewsToCache(
      int page, int limit, String category, NewsListModel news);
}

class NewsLocalDataSourceImp implements INewsLocalDataSource {
  final SharedPreferences sharedPreferences;
  NewsLocalDataSourceImp({required this.sharedPreferences});

  @override
  Future<bool> addNewsToCache(
      int page, int limit, String category, NewsListModel news) async {
    String newsKey =
        '${cacheKeysConstant.CACHED_NEWS_LIST_KEY}$page$limit$category';

    // List newsModelsToJson = news
    //     .map<Map<String, dynamic>>((newsModel) => newsModel.toJson())
    //     .toList();
    String jsonStr = JsonHelper.encode(news.toJson());
    bool result = await CacheHelper(sharedPreferences: sharedPreferences)
        .add(cacheGroupsConstant.CACHED_GROUP_NEWS_KEY, newsKey, jsonStr);
    return Future.value(result);
  }

  @override
  Future<NewsListModel> getNewsFromCache(int page, int limit, String category) {
    String newsKey =
        '${cacheKeysConstant.CACHED_NEWS_LIST_KEY}$page$limit$category';
    Object jsonString = CacheHelper(sharedPreferences: sharedPreferences)
        .get(cacheGroupsConstant.CACHED_GROUP_NEWS_KEY, newsKey, "");

    if (jsonString.toString().isNotEmpty) {
      var decodeJsonData = JsonHelper.decode(jsonString.toString());
      var result = NewsListModel.fromJson(decodeJsonData);
      // List<NewsModel> news = decodeJsonData
      //     .map<NewsModel>((jsonNews) => NewsModel.fromJson(jsonNews))
      //     .toList();
      return Future.value(result);
    } else {
      throw EmptyCacheException();
    }
  }
}
