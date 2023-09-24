import 'package:core_news/core/entities/app_result_entity.dart';
import 'package:core_news/core/errors/failures.dart';

abstract class ILangRepository {
  Future<AppResultEntity<Failure, bool>> changeLang(String lang);
}
