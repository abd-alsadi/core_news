import 'package:core_news/features/auth/domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel({
    required super.userName,
    required super.password,
    required super.token,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    var model = AuthModel(
      userName: json['userName'] ?? '',
      password: json['password'] ?? '',
      token: json['token'] ?? '',
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    var jsonObj = {"userName": userName, "password": password, "token": token};
    return jsonObj;
  }
}
