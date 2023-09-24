import 'package:core_news/core/entities/app_result_entity.dart';
import 'package:core_news/core/errors/failures.dart';
import 'package:core_news/features/news/domain/entities/news_list_entity.dart';
import 'package:core_news/features/news/domain/repositories/news_repository.dart';

class GetNewsSearchUseCase {
  final INewsRepository repository;
  GetNewsSearchUseCase(this.repository);

  Future<AppResultEntity<Failure, NewsListEntity>> call(
      int page, int limit, String search) async {
    return await repository.getNewsSearch(page, limit, search);
  }
}
