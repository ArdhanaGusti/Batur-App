part of 'theme_manager_bloc.dart';

class ThemeManagerState extends Equatable {
  final ThemeModeEnum isDark;
  final String message;

  const ThemeManagerState({
    required this.isDark,
    required this.message,
  });

  ThemeManagerState copyWith({
    ThemeModeEnum? isDark,
    String? message,
  }) {
    return ThemeManagerState(
      isDark: isDark ?? this.isDark,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        isDark,
        message,
      ];
}

class ThemeManagerInitial extends ThemeManagerState {
  static ThemeModeEnum isDarkInit = ThemeModeEnum.systemTheme;
  static String messageInit = '';

  ThemeManagerInitial()
      : super(
          isDark: isDarkInit,
          message: messageInit,
        );
}
