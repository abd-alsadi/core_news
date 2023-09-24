import 'package:core_news/core/entities/app_result_entity.dart';
import 'package:core_news/core/errors/failures.dart';
import 'package:core_news/features/auth/domain/entities/auth_entity.dart';
import 'package:core_news/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final IAuthRepository repository;
  LoginUseCase(this.repository);

  Future<AppResultEntity<Failure, AuthEntity>> call(AuthEntity auth) async {
    return await repository.login(auth);
  }
}
