import 'package:core_news/configs/resources/app_strings.dart';
import 'package:core_news/core/entities/app_result_entity.dart';
import 'package:core_news/core/errors/failures.dart';
import 'package:core_news/features/news/domain/entities/news_list_entity.dart';
import 'package:core_news/features/news/domain/usecases/get_news_search_usecase.dart';
import 'package:core_news/features/news/presentation/bloc/news_search/news_search_event.dart';
import 'package:core_news/features/news/presentation/bloc/news_search/news_search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsSearchBloc extends Bloc<NewsSearchEvent, NewsSearchState> {
  final GetNewsSearchUseCase getNewsSearchUseCase;
  NewsListEntity newsListEntity =
      NewsListEntity(news: const [], hasMore: false);
  int currentPage = 1;
  int limit = 10;
  bool isLoading = false;
  late String? lastSearch;

  NewsSearchBloc({required this.getNewsSearchUseCase})
      : super(NewsSearchStateInitial()) {
    on<NewsSearchEvent>((event, emit) async {
      isLoading = true;
      if (event is GetNewsSearchInit) {
        newsListEntity.news = [];
        newsListEntity.hasMore = false;
        emit(NewsSearchStateInitial());
      } else if (event is GetNewsSearch) {
        lastSearch = event.query;
        emit(LoadingNewsSearchState());
        final failureOrNews =
            await getNewsSearchUseCase.call(currentPage, limit, event.query);
        emit(_mapFailureOrNewsToState(failureOrNews, false));
      } else if (event is GetNewsSearchWithPage) {
        lastSearch = event.query;
        emit(TempNewsSearchState(news: newsListEntity));
        currentPage = currentPage + 1;
        final failureOrNews =
            await getNewsSearchUseCase.call(currentPage, limit, event.query);
        emit(_mapFailureOrNewsToState(failureOrNews, true));
      }
      isLoading = false;
    });
  }

  NewsSearchState _mapFailureOrNewsToState(
      AppResultEntity<Failure, NewsListEntity> failureOrNews, withAdded) {
    var failure = failureOrNews.failure;
    var data = failureOrNews.data;
    if (failure != null) {
      return ErrorNewsSearchState(message: getMessageFromFailure(failure));
    } else {
      var newData = data;
      if (!withAdded) newsListEntity.news = [];
      newsListEntity.news.addAll(newData!.news);
      newsListEntity =
          NewsListEntity(news: newsListEntity.news, hasMore: newData.hasMore);
      if (newsListEntity.news.isEmpty) {
        return ErrorNewsSearchState(
            message: getMessageFromFailure(NotFoundDataFailure()));
      }
      return LoadedNewsSearchState(news: newsListEntity);
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
