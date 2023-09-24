import 'package:core_news/core/entities/app_result_entity.dart';
import 'package:core_news/core/errors/exceptions.dart';
import 'package:core_news/core/errors/failures.dart';
import 'package:core_news/core/networks/network_info.dart';
import 'package:core_news/features/theme/data/data_sources/local/data_sources/theme_local_datasource.dart';
import 'package:core_news/features/theme/domain/repositories/theme_repository.dart';

//typedef Future<bool> MY_NEW_Type();

class ThemeRepositoryImp implements IThemeRepository {
  final IThemeLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ThemeRepositoryImp(
      {required this.localDataSource, required this.networkInfo});

  @override
  Future<AppResultEntity<Failure, bool>> changeTheme(String theme) async {
    bool isAvailableInternet = await networkInfo.isConnectedInternet();
    bool result;
    if (isAvailableInternet) {
      try {
        result = await localDataSource.addThemeToCache(theme);
      } on ServerException {
        return AppResultEntity(failure: ServerFailure());
      }
    } else {
      return AppResultEntity(failure: OfflineFailure());
    }

    return AppResultEntity(data: result);
  }
}
