import 'package:equatable/equatable.dart';

abstract class NewsSearchEvent extends Equatable {
  const NewsSearchEvent();

  @override
  List<Object> get props => [];
}

class GetNewsSearch extends NewsSearchEvent {
  final String query;
  const GetNewsSearch({required this.query});

  @override
  List<Object> get props => [query];
}

class GetNewsSearchInit extends NewsSearchEvent {
  const GetNewsSearchInit();

  @override
  List<Object> get props => [];
}

class GetNewsSearchWithPage extends NewsSearchEvent {
  final int? page;
  final String query;
  const GetNewsSearchWithPage({this.page, required this.query});

  @override
  List<Object> get props => [(page ?? 0, query)];
}
