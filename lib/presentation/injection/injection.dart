import 'package:capstone_design/data/repositories/repository_impl.dart';
import 'package:capstone_design/data/sources/local_data_source.dart';
import 'package:capstone_design/data/sources/shared_preferences_helper.dart';
import 'package:capstone_design/domain/repositories/repository.dart';
import 'package:capstone_design/domain/usecase/get_first_open.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // helper
  locator.registerLazySingleton<SharedPreferencesHelper>(
      () => SharedPreferencesHelper());

  // data sources
  locator.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(databaseHelper: locator()));

  // repository
  locator.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      localDataSource: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetIsFirstOpen(locator()));
}
