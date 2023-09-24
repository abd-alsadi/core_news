import 'package:core_news/core/entities/app_result_entity.dart';
import 'package:core_news/core/errors/failures.dart';
import 'package:core_news/features/theme/domain/repositories/theme_repository.dart';

class ChangeThemeUseCase {
  final IThemeRepository repository;
  ChangeThemeUseCase(this.repository);

  Future<AppResultEntity<Failure, bool>> call(String theme) async {
    return await repository.changeTheme(theme);
  }
}
