import 'package:core_news/core/entities/app_result_entity.dart';
import 'package:core_news/core/errors/exceptions.dart';
import 'package:core_news/core/errors/failures.dart';
import 'package:core_news/core/networks/network_info.dart';
import 'package:core_news/features/lang/data/data_sources/local/data_sources/lang_local_datasource.dart';
import 'package:core_news/features/lang/domain/repositories/lang_repository.dart';

//typedef Future<bool> MY_NEW_Type();

class LangRepositoryImp implements ILangRepository {
  final ILangLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  LangRepositoryImp({required this.localDataSource, required this.networkInfo});

  @override
  Future<AppResultEntity<Failure, bool>> changeLang(String lang) async {
    bool isAvailableInternet = await networkInfo.isConnectedInternet();
    bool result;
    if (isAvailableInternet) {
      try {
        result = await localDataSource.addLangToCache(lang);
      } on ServerException {
        return AppResultEntity(failure: ServerFailure());
      }
    } else {
      return AppResultEntity(failure: OfflineFailure());
    }

    return AppResultEntity(data: result);
  }
}
