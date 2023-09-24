import 'package:core_news/core/entities/app_result_entity.dart';
import 'package:core_news/core/errors/exceptions.dart';
import 'package:core_news/core/errors/failures.dart';
import 'package:core_news/core/networks/network_info.dart';
import 'package:core_news/features/news/data/data_sources/local/data_sources/news_local_datasource.dart';
import 'package:core_news/features/news/data/data_sources/remote/data_sources/news_remote_datasource.dart';
import 'package:core_news/features/news/data/models/news_list_model.dart';
import 'package:core_news/features/news/domain/entities/news_list_entity.dart';
import 'package:core_news/features/news/domain/repositories/news_repository.dart';

//typedef Future<bool> MY_NEW_Type();

class NewsRepositoryImp implements INewsRepository {
  final INewsRemoteDataSource remoteDataSource;
  final INewsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NewsRepositoryImp(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<AppResultEntity<Failure, NewsListEntity>> getNews(
      int page, int limit, String category) async {
    bool isAvailableInternet = await networkInfo.isConnectedInternet();
    NewsListModel result = NewsListModel(news: const [], hasMore: false);
    if (isAvailableInternet) {
      try {
        result = await remoteDataSource.getNews(page, limit, category);
        localDataSource.addNewsToCache(page, limit, category, result);
      } on ServerException {
        return AppResultEntity(failure: ServerFailure());
      }
    } else {
      try {
        result = await localDataSource.getNewsFromCache(page, limit, category);
      } on EmptyCacheException {
        return AppResultEntity(failure: EmptyCacheFailure());
      }
    }

    return AppResultEntity(data: result);
  }

  @override
  Future<AppResultEntity<Failure, NewsListEntity>> getNewsSearch(
      int page, int limit, String search) async {
    bool isAvailableInternet = await networkInfo.isConnectedInternet();
    NewsListModel result = NewsListModel(news: const [], hasMore: false);
    if (isAvailableInternet) {
      try {
        result = await remoteDataSource.getNewsSearch(page, limit, search);
      } on ServerException {
        return AppResultEntity(failure: ServerFailure());
      }
    } else {
      return AppResultEntity(failure: OfflineFailure());
    }

    return AppResultEntity(data: result);
  }
}
