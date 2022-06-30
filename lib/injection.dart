import 'package:get_it/get_it.dart';
import 'package:transportation/transportation.dart';

final locator = GetIt.instance;

void init() {
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
  locator.registerLazySingleton<CrudTrain>(
    () => CrudTrainImpl(
      apiService: locator(),
    ),
  );
  locator.registerLazySingleton<CrudTrain>(
    () => CrudTrainImpl(
      apiService: locator(),
    ),
  );
}
