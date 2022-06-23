import 'package:theme/common/exception.dart';
import 'package:theme/common/theme_mode_enum.dart';
import 'package:theme/data/sources/database_helper.dart';

abstract class ThemeLocalDataSource {
  Future<String> updateTheme(ThemeModeEnum theme);
  Future<ThemeModeEnum> loadTheme();
}

class ThemeDataSourceImpl implements ThemeLocalDataSource {
  final DatabaseHelper databaseHelper;

  ThemeDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> updateTheme(ThemeModeEnum theme) async {
    try {
      final result = await databaseHelper.saveTheme(theme);
      if (result) {
        return 'Save Theme';
      } else {
        return 'Can\'t Save Theme';
      }
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<ThemeModeEnum> loadTheme() async {
    return await databaseHelper.loadTheme();
  }
}
