import 'package:core_news/core/constants/cache_constant.dart';
import 'package:core_news/core/helpers/cache_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IThemeLocalDataSource {
  Future<bool> addThemeToCache(String theme);
}

class ThemeLocalDataSourceImp implements IThemeLocalDataSource {
  final SharedPreferences sharedPreferences;
  ThemeLocalDataSourceImp({required this.sharedPreferences});

  @override
  Future<bool> addThemeToCache(String theme) async {
    bool result = await CacheHelper(sharedPreferences: sharedPreferences).add(
        cacheGroupsConstant.CACHED_GROUP_THEME_KEY,
        cacheGroupsConstant.CACHED_GROUP_THEME_KEY,
        theme);

    return Future.value(result);
  }
}
