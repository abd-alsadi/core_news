import 'package:core_news/core/entities/app_result_entity.dart';
import 'package:core_news/core/errors/failures.dart';
import 'package:core_news/features/auth/domain/entities/auth_entity.dart';

abstract class IAuthRepository {
  Future<AppResultEntity<Failure, AuthEntity>> login(AuthEntity info);
  Future<AppResultEntity<Failure, bool>> logout(AuthEntity info);
}
