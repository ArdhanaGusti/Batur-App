import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme/common/theme_mode_enum.dart';
import 'package:theme/domain/usecase/get_theme.dart';
import 'package:theme/domain/usecase/update_theme.dart';

part 'theme_manager_event.dart';
part 'theme_manager_state.dart';

class ThemeManagerBloc extends Bloc<ThemeManagerEvent, ThemeManagerState> {
  final GetTheme getTheme;
  final UpdateTheme updateTheme;
  ThemeManagerBloc(
    this.getTheme,
    this.updateTheme,
  ) : super(ThemeManagerInitial()) {
    on<SaveThemeMode>((event, emit) async {
      final isDarkNewValue = event.isDark;

      final result = await updateTheme.execute(isDarkNewValue);

      result.fold((failure) {
        emit(state.copyWith(
          message: "Error Update Theme",
        ));
      }, (successMessage) {
        emit(state.copyWith(
          isDark: isDarkNewValue,
          message: successMessage,
        ));
      });
    });

    on<LoadTheme>((event, emit) async {
      final result = await getTheme.execute();

      emit(state.copyWith(
        isDark: result,
      ));
    });
  }
}
