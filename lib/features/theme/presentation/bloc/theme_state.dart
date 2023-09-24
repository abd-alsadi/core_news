import 'package:equatable/equatable.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

class ThemeInitialState extends ThemeState {}

class LoadedThemeState extends ThemeState {
  final String theme;
  const LoadedThemeState({required this.theme});
  @override
  List<Object> get props => [theme];
}
