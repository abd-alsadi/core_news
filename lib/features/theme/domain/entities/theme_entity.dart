import 'package:core_news/core/entities/app_item_entity.dart';

class ThemeEntity extends AppItemEntity {
  //constructor
  const ThemeEntity({
    required super.code,
    required super.nameResource,
    required super.descriptionResource,
  });

  //hash code for equality
  @override
  List<Object?> get props => [code, nameResource, descriptionResource];
}
