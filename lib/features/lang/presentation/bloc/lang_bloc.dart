import 'package:core_news/features/lang/domain/usecases/change_lang_usecase.dart';
import 'package:core_news/features/lang/presentation/bloc/lang_event.dart';
import 'package:core_news/features/lang/presentation/bloc/lang_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LangBloc extends Bloc<LangEvent, LangState> {
  late String currentLang;
  final ChangeLangUseCase changeLangUseCase;

  LangBloc({required this.changeLangUseCase}) : super(LangStateInitial()) {
    on<LangEvent>((event, emit) async {
      if (event is ChangeLangEvent) {
        currentLang = event.lang;
        changeLangUseCase.call(event.lang);
        emit(LoadedLangState(lang: currentLang));
      }
    });
  }
}
