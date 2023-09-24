import 'package:core_news/features/news/domain/entities/news_list_entity.dart';
import 'package:equatable/equatable.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsStateInitial extends NewsState {}

class LoadingNewsState extends NewsState {}

class LoadedNewsState extends NewsState {
  final NewsListEntity news;
  const LoadedNewsState({required this.news});
  @override
  List<Object> get props => [news];
}

class TempNewsState extends NewsState {
  final NewsListEntity news;
  const TempNewsState({required this.news});
  @override
  List<Object> get props => [news];
}

class ErrorNewsState extends NewsState {
  final String message;
  const ErrorNewsState({required this.message});
  @override
  List<Object> get props => [message];
}
