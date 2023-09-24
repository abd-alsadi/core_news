// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:core_news/configs/apis/app_api.dart';
import 'package:core_news/core/errors/exceptions.dart';
import 'package:core_news/core/helpers/json_helper.dart';
import 'package:core_news/core/helpers/log_helper.dart';
import 'package:core_news/features/news/data/models/news_list_model.dart';
import 'package:http/http.dart' as http;

abstract class INewsRemoteDataSource {
  Future<NewsListModel> getNews(int page, int limit, String category);
  Future<NewsListModel> getNewsSearch(int page, int limit, String search);
}

class NewsRemoteDataSourceImp implements INewsRemoteDataSource {
  final http.Client client;
  NewsRemoteDataSourceImp({required this.client});

  @override
  Future<NewsListModel> getNews(int page, int limit, String category) async {
    try {
      var url =
          '${API_BASE_URL}top-headlines?country=us&${API_KEY_PARAM}=${API_KEY}&page=${page}&pageSize=${limit}&category=${category}';

      LogHelper.printConsole(url);
      var uri = Uri.parse(url);
      final response = await client
          .get(uri, headers: API_HEADERS)
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == API_RESPONSE_SUCCESS ||
          response.statusCode == API_RESPONSE_SUCCESS2) {
        final Map<String, dynamic> decodedJson =
            JsonHelper.decode(response.body);
        NewsListModel model =
            NewsListModel.fromJsonRequest(decodedJson, (page * limit));
        return model;
      } else {
        // List<NewsModel> news = [];
        // for (var index = 0; index < 10; index++) {
        //   news.add(NewsModel(
        //       title: 'title',
        //       description: 'description',
        //       publishedAt: 'publishedAt',
        //       url: 'url'));
        // }

        // NewsListModel model = NewsListModel(news: news, hasMore: false);
        // return model;
        throw ServerException();
      }
    } catch (ex) {
      LogHelper.printConsole(ex.toString());
      throw ServerException();
    }
  }

  @override
  Future<NewsListModel> getNewsSearch(
      int page, int limit, String search) async {
    try {
      var url =
          '${API_BASE_URL}everything?${API_KEY_PARAM}=${API_KEY}&page=${page}&pageSize=${limit}&searchIn=title&q=${search.isNotEmpty ? search : "a"}';

      LogHelper.printConsole(url);

      var uri = Uri.parse(url);
      final response = await client
          .get(uri, headers: API_HEADERS)
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == API_RESPONSE_SUCCESS ||
          response.statusCode == API_RESPONSE_SUCCESS2) {
        final Map<String, dynamic> decodedJson =
            JsonHelper.decode(response.body);
        NewsListModel model =
            NewsListModel.fromJsonRequest(decodedJson, (page * limit));
        return model;
      } else {
        // List<NewsModel> news = [];
        // for (var index = 0; index < 10; index++) {
        //   news.add(NewsModel(
        //       title: 'title',
        //       description: 'description',
        //       publishedAt: 'publishedAt',
        //       url: 'url'));
        // }

        // NewsListModel model = NewsListModel(news: news, hasMore: false);
        // return model;
        throw ServerException();
      }
    } catch (ex) {
      LogHelper.printConsole(ex.toString());
      throw ServerException();
    }
  }
}
