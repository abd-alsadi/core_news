// ignore_for_file: prefer_const_constructors

import 'package:core_news/core/entities/app_auth_entity.dart';

class AppAuthModel extends AppAuthEntity {
  const AppAuthModel({
    required super.userName,
    required super.password,
    required super.token,
  });

  factory AppAuthModel.fromJson(Map<String, dynamic> json) {
    var model = AppAuthModel(
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
