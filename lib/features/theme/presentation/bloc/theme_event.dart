import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ChangeThemeEvent extends ThemeEvent {
  final String theme;
  const ChangeThemeEvent({required this.theme});

  @override
  List<Object> get props => [theme];
}
