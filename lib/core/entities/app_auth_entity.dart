import 'package:equatable/equatable.dart';

class AppAuthEntity extends Equatable {
  final String userName;
  final String password;
  final String token;

  //constructor
  const AppAuthEntity({
    required this.userName,
    required this.password,
    required this.token,
  });

  //hash code for equality
  @override
  List<Object?> get props => [
        userName,
        password,
        token,
      ];
}
