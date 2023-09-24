import 'package:core_news/core/errors/exceptions.dart';
import 'package:core_news/core/helpers/auth_helper.dart';
import 'package:core_news/core/helpers/json_helper.dart';
import 'package:core_news/features/auth/data/models/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IAuthLocalDataSource {
  Future<AuthModel> getAuthFromCache();
  Future<bool> addAuthToCache(AuthModel auth);
  Future<bool> removeAuthFromCache(AuthModel auth);
}

class AuthLocalDataSourceImp implements IAuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  AuthLocalDataSourceImp({required this.sharedPreferences});

  @override
  Future<bool> addAuthToCache(AuthModel auth) async {
    String jsonStr = JsonHelper.encode(auth.toJson());
    bool result = await AuthHelper(sharedPreferences: sharedPreferences)
        .setToken(jsonStr);

    return Future.value(result);
  }

  @override
  Future<bool> removeAuthFromCache(AuthModel auth) async {
    bool result =
        await AuthHelper(sharedPreferences: sharedPreferences).clearToken();

    return Future.value(result);
  }

  @override
  Future<AuthModel> getAuthFromCache() {
    Object jsonString =
        AuthHelper(sharedPreferences: sharedPreferences).getToken();

    if (jsonString.toString().isNotEmpty) {
      var decodeJsonData = JsonHelper.decode(jsonString.toString());
      var result = AuthModel.fromJson(decodeJsonData);
      return Future.value(result);
    } else {
      throw EmptyCacheException();
    }
  }
}
