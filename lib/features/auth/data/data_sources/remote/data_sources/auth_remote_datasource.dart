// ignore_for_file: dead_code

import 'package:core_news/core/errors/exceptions.dart';
import 'package:core_news/features/auth/data/models/auth_model.dart';
import 'package:http/http.dart' as http;

abstract class IAuthRemoteDataSource {
  Future<AuthModel> login(AuthModel auth);
  Future<bool> logout(AuthModel auth);
}

class AuthRemoteDataSourceImp implements IAuthRemoteDataSource {
  final http.Client client;
  AuthRemoteDataSourceImp({required this.client});

  @override
  Future<AuthModel> login(AuthModel auth) async {
    try {
      // var url =
      //     '${API_BASE_URL}top-headlines?country=us&${API_KEY_PARAM}=${API_KEY}&page=${page}&pageSize=${limit}&category=${category}';

      // var uri = Uri.parse(url);
      // final response = await client
      //     .get(uri, headers: API_HEADERS)
      //     .timeout(Duration(seconds: 30));
      // if (response.statusCode == API_RESPONSE_SUCCESS ||
      //     response.statusCode == API_RESPONSE_SUCCESS2) {
      if (true) {
        // final Map<String, dynamic> decodedJson =
        //     JSONHelper.decode(response.body) as Map<String, dynamic>;
        // NewsListModel model =
        //     NewsListModel.fromJsonRequest(decodedJson, (page * limit));
        // return model;
        auth = AuthModel(
            userName: auth.userName,
            password: auth.password,
            token: "test token");
        return auth;
      } else {
        throw ServerException();
      }
    } catch (ex) {
      throw ServerException();
    }
  }

  @override
  Future<bool> logout(AuthModel auth) async {
    try {
      // var url =
      //     '${API_BASE_URL}top-headlines?country=us&${API_KEY_PARAM}=${API_KEY}&page=${page}&pageSize=${limit}&category=${category}';

      // var uri = Uri.parse(url);
      // final response = await client
      //     .get(uri, headers: API_HEADERS)
      //     .timeout(Duration(seconds: 30));
      // if (response.statusCode == API_RESPONSE_SUCCESS ||
      //     response.statusCode == API_RESPONSE_SUCCESS2) {
      if (true) {
        // final Map<String, dynamic> decodedJson =
        //     JSONHelper.decode(response.body) as Map<String, dynamic>;
        // NewsListModel model =
        //     NewsListModel.fromJsonRequest(decodedJson, (page * limit));
        // return model;
        return true;
      } else {
        throw ServerException();
      }
    } catch (ex) {
      throw ServerException();
    }
  }
}
