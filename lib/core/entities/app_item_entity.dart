import 'package:equatable/equatable.dart';

class AppItemEntity extends Equatable {
  final String code;
  final String nameResource;
  final String descriptionResource;
  //constructor
  const AppItemEntity({
    required this.code,
    required this.nameResource,
    required this.descriptionResource,
  });

  //hash code for equality
  @override
  List<Object?> get props => [code, nameResource, descriptionResource];
}
