// import 'package:capstone_design/data/datasources/crud_login.dart';
import 'package:account/account.dart';
import 'package:account/domain/usecase/facebook_sign_up.dart';
import 'package:account/domain/usecase/google_sign_up.dart';
import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:transportation/transportation.dart';
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
  locator.registerFactory(
    () => ServiceApiAccount(),
  );

  // Data Source
  locator.registerLazySingleton<AccountLocalDataSource>(
    () => AccountLocalDataSourceImpl(
      databaseHelper: locator(),
    ),
  );
  locator.registerLazySingleton<AccountRemoteDataSource>(
    () => AccountRemoteDataSourceImpl(
      api: locator(),
    ),
  );

  // Helper
  locator.registerLazySingleton<SharedPreferencesHelperAccount>(
    () => SharedPreferencesHelperAccount(),
  );

  // Repositry
  locator.registerLazySingleton<DataAccountRepository>(
    () => DataRepositoryAccountImpl(
      localDataSource: locator(),
      remoteDataSource: locator(),
    ),
  );

  // Use case
  locator.registerLazySingleton(() => GetIsLogIn(locator()));
  locator.registerLazySingleton(() => SaveIsLogIn(locator()));
  locator.registerLazySingleton(() => EmailSignUp(locator()));
  locator.registerLazySingleton(() => EmailSignIn(locator()));
  locator.registerLazySingleton(() => EmailSignOut(locator()));
  locator.registerLazySingleton(() => GoogleSignIn(locator()));
  locator.registerLazySingleton(() => FacebookSignIn(locator()));
  locator.registerLazySingleton(() => GoogleSignUp(locator()));
  locator.registerLazySingleton(() => FacebookSignUp(locator()));
  locator.registerLazySingleton(() => GoogleSignOut(locator()));
  locator.registerLazySingleton(() => FacebookSignOut(locator()));
  locator.registerLazySingleton(() => RegisterProfile(locator()));
  locator.registerLazySingleton(() => EditProfile(locator()));
  locator.registerLazySingleton(() => IsHaveProfile(locator()));
  locator.registerLazySingleton(() => IsAdmin(locator()));
  locator.registerLazySingleton(() => DeleteAuth(locator()));

  // BloC
  locator.registerFactory(
    () => LoginFormBloc(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => UmkmCreateBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => RegisFormBloc(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  // Dashboard BloC

  locator.registerFactory(
    () => DashboardBloc(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  // Use case
  locator.registerLazySingleton(() => GetRememberMe(locator()));
  locator.registerLazySingleton(() => SetRememberMe(locator()));

  // Profile BloC

  locator.registerFactory(
    () => ProfileBloc(
      locator(),
    ),
  );

  // Is First Open

  // Helper
  locator.registerLazySingleton<SharedPreferencesHelper>(
    () => SharedPreferencesHelper(),
  );

  // Data sources
  locator.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(
      databaseHelper: locator(),
    ),
  );

  // Repository
  locator.registerLazySingleton<CoreRepository>(
    () => CoreRepositoryImpl(
      localDataSource: locator(),
    ),
  );

  // Use case
  locator.registerLazySingleton(() => GetIsFirstOpen(locator()));
  //helper

  //factory
  locator.registerFactory(
    () => TrainCreateBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TrainUpdateBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TrainRemoveBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => ApiServiceTrans(),
  );

  locator.registerFactory(
    () => ApiServiceNews(),
  );
  locator.registerFactory(() => ApiServiceUMKM());

  //usecase
  locator.registerLazySingleton(() => CreateTrain(locator()));
  locator.registerLazySingleton(() => UpdateTrain(locator()));
  locator.registerLazySingleton(() => RemoveTrain(locator()));

  //repository
  locator.registerLazySingleton<DataRepositoryTrans>(
    () => DataRepositoryTransImpl(
      crudTrain: locator(),
    ),
  );
  //datasource
  locator.registerLazySingleton(() => CreateNews(locator()));
  locator.registerLazySingleton(() => CreateUmkm(locator()));
  locator.registerLazySingleton(() => UpdateNews(locator()));
  locator.registerLazySingleton(() => UpdateUmkm(locator()));
  locator.registerLazySingleton(() => RemoveNews(locator()));
  locator.registerLazySingleton(() => RemoveUmkm(locator()));

  locator.registerLazySingleton<CrudTrain>(
    () => CrudTrainImpl(apiService: locator()),
  );
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
