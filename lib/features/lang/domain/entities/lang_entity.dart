import 'package:core_news/core/entities/app_item_entity.dart';

class LangEntity extends AppItemEntity {
  //constructor
  const LangEntity({
    required super.code,
    required super.nameResource,
    required super.descriptionResource,
  });

  //hash code for equality
  @override
  List<Object?> get props => [code, nameResource, descriptionResource];
}
