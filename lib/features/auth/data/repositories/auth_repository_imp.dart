import 'package:core_news/core/entities/app_result_entity.dart';
import 'package:core_news/core/errors/exceptions.dart';
import 'package:core_news/core/errors/failures.dart';
import 'package:core_news/core/networks/network_info.dart';
import 'package:core_news/features/auth/data/data_sources/local/data_sources/auth_local_datasource.dart';
import 'package:core_news/features/auth/data/data_sources/remote/data_sources/auth_remote_datasource.dart';
import 'package:core_news/features/auth/data/models/auth_model.dart';
import 'package:core_news/features/auth/domain/entities/auth_entity.dart';
import 'package:core_news/features/auth/domain/repositories/auth_repository.dart';

//typedef Future<bool> MY_NEW_Type();

class AuthRepositoryImp implements IAuthRepository {
  final IAuthRemoteDataSource remoteDataSource;
  final IAuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImp(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<AppResultEntity<Failure, AuthEntity>> login(AuthEntity auth) async {
    bool isAvailableInternet = await networkInfo.isConnectedInternet();
    AuthModel result;
    if (isAvailableInternet) {
      try {
        result = await remoteDataSource.login(AuthModel(
            userName: auth.userName,
            password: auth.password,
            token: auth.token));
        localDataSource.addAuthToCache(result);
      } on ServerException {
        return AppResultEntity(failure: ServerFailure());
      }
    } else {
      return AppResultEntity(failure: OfflineFailure());
    }

    return AppResultEntity(data: result);
  }

  @override
  Future<AppResultEntity<Failure, bool>> logout(AuthEntity auth) async {
    bool isAvailableInternet = await networkInfo.isConnectedInternet();
    bool result = false;
    if (isAvailableInternet) {
      try {
        AuthModel authModel = AuthModel(
            userName: auth.userName,
            password: auth.password,
            token: auth.token);
        result = await remoteDataSource.logout(authModel);
        localDataSource.removeAuthFromCache(authModel);
        result = true;
      } on ServerException {
        return AppResultEntity(failure: ServerFailure());
      }
    } else {
      return AppResultEntity(failure: OfflineFailure());
    }

    return AppResultEntity(data: result);
  }
}
