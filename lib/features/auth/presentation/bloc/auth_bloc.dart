// ignore_for_file: unused_local_variable

import 'package:core_news/configs/resources/app_strings.dart';
import 'package:core_news/core/errors/failures.dart';
import 'package:core_news/features/auth/domain/entities/auth_entity.dart';
import 'package:core_news/features/auth/domain/usecases/login_usecase.dart';
import 'package:core_news/features/auth/domain/usecases/logout_usecase.dart';
import 'package:core_news/features/auth/presentation/bloc/auth_event.dart';
import 'package:core_news/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  late AuthEntity? auth;

  AuthBloc({required this.loginUseCase, required this.logoutUseCase})
      : super(AuthStateInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthInitEvent) {
        auth = event.auth;
      } else if (event is LoginEvent) {
        emit(LoadingAuthState());
        final failureOrLogin = await loginUseCase.call(AuthEntity(
            userName: event.userName, password: event.password, token: ""));

        var failure = failureOrLogin.failure;
        var data = failureOrLogin.data;
        if (failure != null) {
          emit(ErrorAuthState(message: getMessageFromFailure(failure)));
        } else {
          auth = data;
          var result = SuccessLoginState(
              userName: auth!.userName,
              password: auth!.password,
              token: auth!.token);
          emit(result);
        }
      } else if (event is LogoutEvent) {
        final failureOrLogin = await logoutUseCase.call(
            auth ?? const AuthEntity(userName: '', password: '', token: ''));

        var failure = failureOrLogin.failure;
        var data = failureOrLogin.data;
        if (failure != null) {
          emit(ErrorAuthState(message: getMessageFromFailure(failure)));
        } else {
          auth = null;
          emit(SuccesLogoutState());
        }
      }
    });
  }
  String getMessageFromFailure(Failure? failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return appStrings.SERVER_FAILURE_MESSAGE_KEY;
      case OfflineFailure:
        return appStrings.OFFLINE_FAILURE_MESSAGE_KEY;
    }
    return appStrings.UN_EXPECTED_FAILURE_MESSAGE_KEY;
  }
}
