import 'package:get_it/get_it.dart';
import 'package:theme/data/repositories/theme_repository_impl.dart';
import 'package:theme/data/sources/database_helper.dart';
import 'package:theme/data/sources/theme_local_data_source.dart';
import 'package:theme/domain/repositories/theme_repository.dart';
import 'package:theme/domain/usecase/get_theme.dart';
import 'package:theme/domain/usecase/update_theme.dart';
import 'package:theme/presentation/bloc/theme_manager_bloc.dart';

final locator = GetIt.instance;

void init() {
  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // data sources
  locator.registerLazySingleton<ThemeLocalDataSource>(
      () => ThemeDataSourceImpl(databaseHelper: locator()));

  // repository
  locator.registerLazySingleton<ThemeRepository>(
    () => ThemeRepositoryImpl(
      localDataSource: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetTheme(locator()));
  locator.registerLazySingleton(() => UpdateTheme(locator()));

  // bloc
  locator.registerFactory(
    () => ThemeManagerBloc(
      locator(),
      locator(),
    ),
  );
}
