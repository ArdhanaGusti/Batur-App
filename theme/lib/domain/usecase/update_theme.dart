import 'package:dartz/dartz.dart';
import 'package:theme/common/failure.dart';
import 'package:theme/common/theme_mode_enum.dart';
import 'package:theme/domain/repositories/theme_repository.dart';

class UpdateTheme {
  final ThemeRepository repository;

  UpdateTheme(this.repository);

  Future<Either<Failure, String>> execute(ThemeModeEnum theme) {
    return repository.updateTheme(theme);
  }
}
