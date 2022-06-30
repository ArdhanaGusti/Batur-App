import 'package:news/data/datasources/crud_news.dart';
import 'package:news/data/repositories/data_repository_impl.dart';
import 'package:news/data/service/api_service.dart';
import 'package:news/domain/repositories/data_repository.dart';
import 'package:news/news.dart';
import 'package:umkm/umkm.dart';
import 'package:get_it/get_it.dart';
import 'package:news/presentation/bloc/news_create_bloc.dart';

final locator = GetIt.instance;

void init() {
  //helper
  //factory
  locator.registerFactory(
    () => NewsCreateBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => NewsUpdateBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => NewsRemoveBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => UmkmCreateBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => UmkmUpdateBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => UmkmRemoveBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => ApiServiceNews(),
  );
  locator.registerFactory(() => ApiServiceUMKM());

  //usecase
  locator.registerLazySingleton(() => CreateNews(locator()));
  locator.registerLazySingleton(() => CreateUmkm(locator()));
  locator.registerLazySingleton(() => UpdateNews(locator()));
  locator.registerLazySingleton(() => UpdateUmkm(locator()));
  locator.registerLazySingleton(() => RemoveNews(locator()));
  locator.registerLazySingleton(() => RemoveUmkm(locator()));

  locator.registerLazySingleton<DataRepositoryNews>(
    () => DataRepositoryImplNews(crudNews: locator()),
  );
  locator.registerLazySingleton<DataRepositoryUmkm>(
    () => DataRepositoryImplUmkm(crudUmkm: locator()),
  );
  //datasource
  locator.registerLazySingleton<CrudNews>(
    () => CrudNewsImpl(
      apiServiceNews: locator(),
    ),
  );
  locator.registerLazySingleton<CrudUmkm>(
    () => CrudUmkmImpl(
      apiService: locator(),
    ),
  );
}
