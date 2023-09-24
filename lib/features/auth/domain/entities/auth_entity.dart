import 'package:core_news/core/entities/app_auth_entity.dart';

class AuthEntity extends AppAuthEntity {
  //constructor
  const AuthEntity({
    required super.userName,
    required super.password,
    required super.token,
  });

  //hash code for equality
  @override
  List<Object?> get props => [
        userName,
        password,
        token,
      ];
}
