import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class GetNews extends NewsEvent {
  final int categoryIndex;
  final String categoryName;
  const GetNews({required this.categoryIndex, required this.categoryName});

  @override
  List<Object> get props => [categoryIndex, categoryName];
}

class GetNewsWithPage extends NewsEvent {
  final int? page;
  final int categoryIndex;
  final String categoryName;
  const GetNewsWithPage(
      {this.page, required this.categoryIndex, required this.categoryName});

  @override
  List<Object> get props => [(page ?? 0, categoryIndex, categoryName)];
}

class GetNewsByTabCached extends NewsEvent {
  final int? page;
  final int categoryIndex;
  final String categoryName;
  const GetNewsByTabCached(
      {this.page, required this.categoryIndex, required this.categoryName});

  @override
  List<Object> get props => [(page ?? 0, categoryIndex, categoryName)];
}
