import 'package:capstone_design/data/datasources/crud_news.dart';
import 'package:capstone_design/data/datasources/crud_profile.dart';
import 'package:capstone_design/data/datasources/crud_umkm.dart';
import 'package:capstone_design/data/repositories/data_repository_impl.dart';
import 'package:capstone_design/data/service/api_service.dart';
import 'package:capstone_design/domain/repository/data_repository.dart';
import 'package:capstone_design/domain/usecase/create_news.dart';
import 'package:capstone_design/domain/usecase/create_profile.dart';
import 'package:capstone_design/domain/usecase/create_umkm.dart';
import 'package:capstone_design/domain/usecase/update_news.dart';
import 'package:capstone_design/domain/usecase/update_profile.dart';
import 'package:capstone_design/domain/usecase/update_umkm.dart';
import 'package:capstone_design/presentation/bloc/news/news_create_bloc.dart';
import 'package:capstone_design/presentation/bloc/news/news_update_bloc.dart';
import 'package:capstone_design/presentation/bloc/profile/profile_create_bloc.dart';
import 'package:capstone_design/presentation/bloc/profile/profile_update_bloc.dart';
import 'package:capstone_design/presentation/bloc/umkm/umkm_create_bloc.dart';
import 'package:capstone_design/presentation/bloc/umkm/umkm_update_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
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
    () => ProfileCreateBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => ProfileUpdateBloc(
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
    () => ApiService(),
  );
  //usecase
  locator.registerLazySingleton(() => CreateNews(locator()));
  locator.registerLazySingleton(() => CreateProfile(locator()));
  locator.registerLazySingleton(() => CreateUmkm(locator()));
  locator.registerLazySingleton(() => UpdateNews(locator()));
  locator.registerLazySingleton(() => UpdateUmkm(locator()));
  locator.registerLazySingleton(() => UpdateProfile(locator()));
  //repository
  locator.registerLazySingleton<DataRepository>(
    () => DataRepositoryImpl(
      crudNews: locator(),
      crudProfile: locator(),
      crudUmkm: locator(),
    ),
  );
  //datasource
  locator.registerLazySingleton<CrudNews>(
    () => CrudNewsImpl(
      apiService: locator(),
    ),
  );
  locator.registerLazySingleton<CrudUmkm>(
    () => CrudUmkmImpl(
      apiService: locator(),
    ),
  );
  locator.registerLazySingleton<CrudProfile>(
    () => CrudProfileImpl(
      apiService: locator(),
    ),
  );
}