import 'package:equatable/equatable.dart';

abstract class LangEvent extends Equatable {
  const LangEvent();

  @override
  List<Object> get props => [];
}

class ChangeLangEvent extends LangEvent {
  final String lang;
  const ChangeLangEvent({required this.lang});

  @override
  List<Object> get props => [lang];
}
