import 'package:dartz/dartz.dart';
import 'package:theme/common/exception.dart';
import 'package:theme/common/failure.dart';
import 'package:theme/common/theme_mode_enum.dart';
import 'package:theme/data/sources/theme_local_data_source.dart';
import 'package:theme/domain/repositories/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource localDataSource;

  ThemeRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, String>> updateTheme(ThemeModeEnum theme) async {
    try {
      final result = await localDataSource.updateTheme(theme);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ThemeModeEnum> loadTheme() async {
    final result = await localDataSource.loadTheme();

    return result;
  }
}
