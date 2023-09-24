import 'package:core_news/core/constants/cache_constant.dart';
import 'package:core_news/core/helpers/cache_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ILangLocalDataSource {
  Future<bool> addLangToCache(String lang);
}

class LangLocalDataSourceImp implements ILangLocalDataSource {
  final SharedPreferences sharedPreferences;
  LangLocalDataSourceImp({required this.sharedPreferences});

  @override
  Future<bool> addLangToCache(String lang) async {
    bool result = await CacheHelper(sharedPreferences: sharedPreferences).add(
        cacheGroupsConstant.CACHED_GROUP_LANG_KEY,
        cacheGroupsConstant.CACHED_GROUP_LANG_KEY,
        lang);

    return Future.value(result);
  }
}
