import 'package:equatable/equatable.dart';

abstract class LangState extends Equatable {
  const LangState();

  @override
  List<Object> get props => [];
}

class LangStateInitial extends LangState {}

class LoadedLangState extends LangState {
  final String lang;
  const LoadedLangState({required this.lang});
  @override
  List<Object> get props => [lang];
}
