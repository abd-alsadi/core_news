import 'package:core_news/configs/resources/app_strings.dart';
import 'package:core_news/core/entities/app_result_entity.dart';
import 'package:core_news/core/errors/failures.dart';
import 'package:core_news/features/news/domain/entities/news_list_entity.dart';
import 'package:core_news/features/news/domain/usecases/get_news_usecase.dart';
import 'package:core_news/features/news/presentation/bloc/news/news_event.dart';
import 'package:core_news/features/news/presentation/bloc/news/news_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsUseCase getNewsUseCase;
  NewsListEntity currentNewsList =
      NewsListEntity(news: const [], hasMore: false);
  int currentPage = 1;
  int limit = 10;
  bool isLoading = false;

  late Map<int, NewsListEntity> tabsData = <int, NewsListEntity>{};

  NewsBloc({required this.getNewsUseCase}) : super(NewsStateInitial()) {
    on<NewsEvent>((event, emit) async {
      isLoading = true;
      if (event is GetNews) {
        currentPage = 1;
        emit(LoadingNewsState());
        final failureOrNews =
            await getNewsUseCase.call(1, limit, event.categoryName);
        emit(_mapFailureOrNewsToState(
            failureOrNews, false, event.categoryIndex));
      } else if (event is GetNewsByTabCached) {
        currentPage = 1;
        if (tabsData.containsKey(event.categoryIndex)) {
          emit(LoadingNewsState());
          var list = tabsData[event.categoryIndex]!.news;
          if (list.isNotEmpty) {
            var cahedData = NewsListEntity(
                news: list, hasMore: tabsData[event.categoryIndex]!.hasMore);
            emit(LoadedNewsState(news: cahedData));
          } else {
            emit(ErrorNewsState(
                message: getMessageFromFailure(NotFoundDataFailure())));
          }
        } else {
          emit(LoadingNewsState());
          final failureOrNews =
              await getNewsUseCase.call(currentPage, limit, event.categoryName);
          emit(_mapFailureOrNewsToState(
              failureOrNews, false, event.categoryIndex));
        }
      } else if (event is GetNewsWithPage) {
        emit(TempNewsState(news: currentNewsList));
        currentPage = currentPage + 1;
        final failureOrNews =
            await getNewsUseCase.call(currentPage, limit, event.categoryName);
        emit(
            _mapFailureOrNewsToState(failureOrNews, true, event.categoryIndex));
      }
      isLoading = false;
    });
  }

  NewsState _mapFailureOrNewsToState(
      AppResultEntity<Failure, NewsListEntity> failureOrNews,
      withAdded,
      categoryIndex) {
    var failure = failureOrNews.failure;
    var data = failureOrNews.data;
    if (failure != null) {
      if (failureOrNews.failure.runtimeType == EmptyCacheFailure) {
        var tabData = tabsData[categoryIndex]?.clone();
        if (tabData != null && tabData.news.isNotEmpty) {
          //return cached data
          tabData.hasMore = false;
          return LoadedNewsState(news: tabData);
        }
      }
      return ErrorNewsState(message: getMessageFromFailure(failure));
    } else {
      var newData = data;
      if (!withAdded) currentNewsList.news = [];
      currentNewsList.news.addAll(newData!.news);
      currentNewsList.hasMore = newData.hasMore;
      tabsData[categoryIndex] = currentNewsList.clone();
      //return before data and new data
      if (currentNewsList.news.isEmpty) {
        return ErrorNewsState(
            message: getMessageFromFailure(NotFoundDataFailure()));
      }
      return LoadedNewsState(news: currentNewsList);
    }
  }

  String getMessageFromFailure(Failure? failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return appStrings.SERVER_FAILURE_MESSAGE_KEY;
      case EmptyCacheFailure:
        return appStrings.EMPTY_CACHED_FAILURE_MESSAGE_KEY;
      case OfflineFailure:
        return appStrings.OFFLINE_FAILURE_MESSAGE_KEY;
      case NotFoundDataFailure:
        return appStrings.NOT_FOUND_DATA_FAILURE_MESSAGE_KEY;
    }
    return appStrings.UN_EXPECTED_FAILURE_MESSAGE_KEY;
  }
}
