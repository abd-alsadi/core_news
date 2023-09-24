import 'package:core_news/core/constants/cache_constant.dart';
import 'package:core_news/core/entities/app_auth_entity.dart';
import 'package:core_news/core/helpers/cache_helper.dart';
import 'package:core_news/core/helpers/json_helper.dart';
import 'package:core_news/core/models/app_auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  final SharedPreferences sharedPreferences;
  const AuthHelper({required this.sharedPreferences});

  String getToken() {
    var tokenValue = CacheHelper(sharedPreferences: sharedPreferences)
        .get(cacheGroupsConstant.CACHED_GROUP_AUTH_KEY,
            cacheGroupsConstant.CACHED_GROUP_AUTH_KEY, "")
        .toString();
    return tokenValue;
  }

  AppAuthEntity? getAuth() {
    var tokenValue = CacheHelper(sharedPreferences: sharedPreferences)
        .get(cacheGroupsConstant.CACHED_GROUP_AUTH_KEY,
            cacheGroupsConstant.CACHED_GROUP_AUTH_KEY, "")
        .toString();

    if (tokenValue.isEmpty) {
      return null;
    }
    var decode = JsonHelper.decode(tokenValue);
    var result = AppAuthModel.fromJson(decode);

    return result;
  }

  Future<bool> setToken(token) async {
    bool result = await CacheHelper(sharedPreferences: sharedPreferences).add(
        cacheGroupsConstant.CACHED_GROUP_AUTH_KEY,
        cacheGroupsConstant.CACHED_GROUP_AUTH_KEY,
        token);
    return result;
  }

  Future<bool> clearToken() async {
    bool result = await CacheHelper(sharedPreferences: sharedPreferences)
        .remove(cacheGroupsConstant.CACHED_GROUP_AUTH_KEY,
            cacheGroupsConstant.CACHED_GROUP_AUTH_KEY);
    return result;
  }
}
