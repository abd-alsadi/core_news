import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthStateInitial extends AuthState {}

class LoadingAuthState extends AuthState {}

class SuccessLoginState extends AuthState {
  final String userName;
  final String password;
  final String token;
  const SuccessLoginState(
      {required this.userName, required this.password, required this.token});
  @override
  List<Object> get props => [userName, password, token];
}

class SuccesLogoutState extends AuthState {}

class ErrorAuthState extends AuthState {
  final String message;

  const ErrorAuthState({required this.message});
  @override
  List<Object> get props => [message];
}
