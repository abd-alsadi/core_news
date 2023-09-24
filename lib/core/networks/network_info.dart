// ignore_for_file: camel_case_types

import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> isConnectedInternet();
}

class NetworkInfoImp implements NetworkInfo {
  @override
  Future<bool> isConnectedInternet() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }
}
