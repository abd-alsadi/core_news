import 'package:core_news/core/networks/network_info.dart';
import 'package:core_news/features/auth/data/data_sources/local/data_sources/auth_local_datasource.dart';
import 'package:core_news/features/auth/data/data_sources/remote/data_sources/auth_remote_datasource.dart';
import 'package:core_news/features/auth/data/repositories/auth_repository_imp.dart';
import 'package:core_news/features/auth/domain/repositories/auth_repository.dart';
import 'package:core_news/features/auth/domain/usecases/login_usecase.dart';
import 'package:core_news/features/auth/domain/usecases/logout_usecase.dart';
import 'package:core_news/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:core_news/features/lang/data/data_sources/local/data_sources/lang_local_datasource.dart';
import 'package:core_news/features/lang/data/repositories/lang_repository_imp.dart';
import 'package:core_news/features/lang/domain/repositories/lang_repository.dart';
import 'package:core_news/features/lang/domain/usecases/change_lang_usecase.dart';
import 'package:core_news/features/lang/presentation/bloc/lang_bloc.dart';
import 'package:core_news/features/news/data/data_sources/local/data_sources/news_local_datasource.dart';
import 'package:core_news/features/news/data/data_sources/remote/data_sources/news_remote_datasource.dart';
import 'package:core_news/features/news/data/repositories/news_repository_imp.dart';
import 'package:core_news/features/news/domain/repositories/news_repository.dart';
import 'package:core_news/features/news/domain/usecases/get_news_search_usecase.dart';
import 'package:core_news/features/news/domain/usecases/get_news_usecase.dart';
import 'package:core_news/features/news/presentation/bloc/news/news_bloc.dart';
import 'package:core_news/features/news/presentation/bloc/news_search/news_search_bloc.dart';
import 'package:core_news/features/theme/data/data_sources/local/data_sources/theme_local_datasource.dart';
import 'package:core_news/features/theme/data/repositories/theme_repository_imp.dart';
import 'package:core_news/features/theme/domain/repositories/theme_repository.dart';
import 'package:core_news/features/theme/domain/usecases/change_theme_usecase.dart';
import 'package:core_news/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //Feature Posts

  //Bloc

  sl.registerFactory(() => NewsBloc(getNewsUseCase: sl()));
  sl.registerFactory(() => NewsSearchBloc(getNewsSearchUseCase: sl()));
  sl.registerFactory(() => LangBloc(changeLangUseCase: sl()));
  sl.registerFactory(() => ThemeBloc(changeThemeUseCase: sl()));
  sl.registerFactory(() => AuthBloc(loginUseCase: sl(), logoutUseCase: sl()));

  //Usecases

  sl.registerLazySingleton(() => GetNewsUseCase(sl()));
  sl.registerLazySingleton(() => GetNewsSearchUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => ChangeLangUseCase(sl()));
  sl.registerLazySingleton(() => ChangeThemeUseCase(sl()));

  //Repositories

  sl.registerLazySingleton<INewsRepository>(() => NewsRepositoryImp(
      localDataSource: sl(), remoteDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<IAuthRepository>(() => AuthRepositoryImp(
      localDataSource: sl(), remoteDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<ILangRepository>(
      () => LangRepositoryImp(localDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<IThemeRepository>(
      () => ThemeRepositoryImp(localDataSource: sl(), networkInfo: sl()));

  //DataSources

  sl.registerLazySingleton<INewsRemoteDataSource>(
      () => NewsRemoteDataSourceImp(client: sl()));

  sl.registerLazySingleton<IAuthRemoteDataSource>(
      () => AuthRemoteDataSourceImp(client: sl()));

  sl.registerLazySingleton<INewsLocalDataSource>(
      () => NewsLocalDataSourceImp(sharedPreferences: sl()));

  sl.registerLazySingleton<IAuthLocalDataSource>(
      () => AuthLocalDataSourceImp(sharedPreferences: sl()));

  sl.registerLazySingleton<ILangLocalDataSource>(
      () => LangLocalDataSourceImp(sharedPreferences: sl()));

  sl.registerLazySingleton<IThemeLocalDataSource>(
      () => ThemeLocalDataSourceImp(sharedPreferences: sl()));

  //Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp());

  //External

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
}
