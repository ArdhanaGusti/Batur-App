part of 'theme_manager_bloc.dart';

abstract class ThemeManagerEvent extends Equatable {
  const ThemeManagerEvent();

  @override
  List<Object> get props => [];
}

class SaveThemeMode extends ThemeManagerEvent {
  final ThemeModeEnum isDark;
  const SaveThemeMode({required this.isDark});

  @override
  List<Object> get props => [isDark];
}

class LoadTheme extends ThemeManagerEvent {
  const LoadTheme();

  @override
  List<Object> get props => [];
}
