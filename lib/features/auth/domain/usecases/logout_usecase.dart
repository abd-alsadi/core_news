import 'package:core_news/core/entities/app_result_entity.dart';
import 'package:core_news/core/errors/failures.dart';
import 'package:core_news/features/auth/domain/entities/auth_entity.dart';
import 'package:core_news/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final IAuthRepository repository;
  LogoutUseCase(this.repository);

  Future<AppResultEntity<Failure, bool>> call(AuthEntity auth) async {
    return await repository.logout(auth);
  }
}
