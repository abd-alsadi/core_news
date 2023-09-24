import 'package:core_news/features/news/domain/entities/news_list_entity.dart';
import 'package:equatable/equatable.dart';

abstract class NewsSearchState extends Equatable {
  const NewsSearchState();

  @override
  List<Object> get props => [];
}

class NewsSearchStateInitial extends NewsSearchState {}

class LoadingNewsSearchState extends NewsSearchState {}

class LoadedNewsSearchState extends NewsSearchState {
  final NewsListEntity news;
  const LoadedNewsSearchState({required this.news});
  @override
  List<Object> get props => [news];
}

class TempNewsSearchState extends NewsSearchState {
  final NewsListEntity news;
  const TempNewsSearchState({required this.news});
  @override
  List<Object> get props => [news];
}

class ErrorNewsSearchState extends NewsSearchState {
  final String message;
  const ErrorNewsSearchState({required this.message});
  @override
  List<Object> get props => [message];
}
