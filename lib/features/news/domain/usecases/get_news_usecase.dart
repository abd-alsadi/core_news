import 'package:core_news/core/entities/app_result_entity.dart';
import 'package:core_news/core/errors/failures.dart';
import 'package:core_news/features/news/domain/entities/news_list_entity.dart';
import 'package:core_news/features/news/domain/repositories/news_repository.dart';

class GetNewsUseCase {
  final INewsRepository repository;
  GetNewsUseCase(this.repository);

  Future<AppResultEntity<Failure, NewsListEntity>> call(
      int page, int limit, String category) async {
    return await repository.getNews(page, limit, category);
  }
}
