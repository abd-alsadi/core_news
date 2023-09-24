import 'package:core_news/features/auth/domain/entities/auth_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String userName;
  final String password;
  const LoginEvent({required this.userName, required this.password});

  @override
  List<Object> get props => [userName, password];
}

class LogoutEvent extends AuthEvent {
  const LogoutEvent();

  @override
  List<Object> get props => [];
}

class AuthInitEvent extends AuthEvent {
  const AuthInitEvent({required this.auth});
  final AuthEntity? auth;

  @override
  List<Object> get props => [auth ?? ''];
}
