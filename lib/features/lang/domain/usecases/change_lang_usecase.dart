import 'package:core_news/core/entities/app_result_entity.dart';
import 'package:core_news/core/errors/failures.dart';
import 'package:core_news/features/lang/domain/repositories/lang_repository.dart';

class ChangeLangUseCase {
  final ILangRepository repository;
  ChangeLangUseCase(this.repository);

  Future<AppResultEntity<Failure, bool>> call(String lang) async {
    return await repository.changeLang(lang);
  }
}
