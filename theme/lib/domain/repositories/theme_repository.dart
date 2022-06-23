import 'package:dartz/dartz.dart';
import 'package:theme/common/failure.dart';
import 'package:theme/common/theme_mode_enum.dart';

abstract class ThemeRepository {
  Future<Either<Failure, String>> updateTheme(ThemeModeEnum theme);
  Future<ThemeModeEnum> loadTheme();
}
