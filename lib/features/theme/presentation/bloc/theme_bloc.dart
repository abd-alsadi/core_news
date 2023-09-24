import 'package:core_news/features/theme/domain/usecases/change_theme_usecase.dart';
import 'package:core_news/features/theme/presentation/bloc/theme_event.dart';
import 'package:core_news/features/theme/presentation/bloc/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  late String currentTheme;
  final ChangeThemeUseCase changeThemeUseCase;
  ThemeBloc({required this.changeThemeUseCase}) : super(ThemeInitialState()) {
    on<ThemeEvent>((event, emit) async {
      if (event is ChangeThemeEvent) {
        currentTheme = event.theme;
        changeThemeUseCase.call(event.theme);
        emit(LoadedThemeState(theme: currentTheme));
      }
    });
  }
}
