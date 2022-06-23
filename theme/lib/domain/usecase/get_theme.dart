import 'package:theme/common/theme_mode_enum.dart';
import 'package:theme/domain/repositories/theme_repository.dart';

class GetTheme {
  final ThemeRepository repository;

  GetTheme(this.repository);

  Future<ThemeModeEnum> execute() async {
    return repository.loadTheme();
  }
}
