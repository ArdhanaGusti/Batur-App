import 'package:capstone_design/data/datasources/crud_news.dart';
import 'package:capstone_design/data/datasources/crud_profile.dart';
import 'package:capstone_design/data/datasources/crud_tour.dart';
import 'package:capstone_design/data/datasources/crud_train.dart';
import 'package:capstone_design/data/datasources/crud_umkm.dart';
import 'package:capstone_design/data/repositories/data_repository_impl.dart';
import 'package:capstone_design/data/service/api_service.dart';
import 'package:capstone_design/domain/repository/data_repository.dart';
import 'package:capstone_design/domain/usecase/create_news.dart';
import 'package:capstone_design/domain/usecase/create_profile.dart';
import 'package:capstone_design/domain/usecase/create_tour.dart';
import 'package:capstone_design/domain/usecase/create_train.dart';
import 'package:capstone_design/domain/usecase/create_umkm.dart';
import 'package:capstone_design/domain/usecase/remove_news.dart';
import 'package:capstone_design/domain/usecase/remove_tour.dart';
import 'package:capstone_design/domain/usecase/remove_umkm.dart';
import 'package:capstone_design/domain/usecase/update_news.dart';
import 'package:capstone_design/domain/usecase/update_profile.dart';
import 'package:capstone_design/domain/usecase/update_tour.dart';
import 'package:capstone_design/domain/usecase/update_train.dart';
import 'package:capstone_design/domain/usecase/update_umkm.dart';
import 'package:capstone_design/presentation/bloc/news/news_create_bloc.dart';
import 'package:capstone_design/presentation/bloc/news/news_remove_bloc.dart';
import 'package:capstone_design/presentation/bloc/news/news_update_bloc.dart';
import 'package:capstone_design/presentation/bloc/profile/profile_create_bloc.dart';
import 'package:capstone_design/presentation/bloc/profile/profile_update_bloc.dart';
import 'package:capstone_design/presentation/bloc/tour/tour_create_bloc.dart';
import 'package:capstone_design/presentation/bloc/tour/tour_remove_bloc.dart';
import 'package:capstone_design/presentation/bloc/tour/tour_update_bloc.dart';
import 'package:capstone_design/presentation/bloc/train/train_create_bloc.dart';
import 'package:capstone_design/presentation/bloc/train/train_remove_bloc.dart';
import 'package:capstone_design/presentation/bloc/train/train_update_bloc.dart';
import 'package:capstone_design/presentation/bloc/umkm/umkm_create_bloc.dart';
import 'package:capstone_design/presentation/bloc/umkm/umkm_remove_bloc.dart';
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
    () => NewsRemoveBloc(
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
    () => UmkmRemoveBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TourUpdateBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TourCreateBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TourRemoveBloc(
      locator(),
    ),
  );
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
  //Service
  locator.registerFactory(
    () => ApiService(),
  );
  //usecase
  locator.registerLazySingleton(() => CreateNews(locator()));
  locator.registerLazySingleton(() => CreateProfile(locator()));
  locator.registerLazySingleton(() => CreateTour(locator()));
  locator.registerLazySingleton(() => CreateUmkm(locator()));
  locator.registerLazySingleton(() => CreateTrain(locator()));
  locator.registerLazySingleton(() => UpdateNews(locator()));
  locator.registerLazySingleton(() => UpdateUmkm(locator()));
  locator.registerLazySingleton(() => UpdateProfile(locator()));
  locator.registerLazySingleton(() => UpdateTour(locator()));
  locator.registerLazySingleton(() => UpdateTrain(locator()));
  locator.registerLazySingleton(() => RemoveTour(locator()));
  locator.registerLazySingleton(() => RemoveNews(locator()));
  locator.registerLazySingleton(() => RemoveUmkm(locator()));

  //repository
  locator.registerLazySingleton<DataRepository>(
    () => DataRepositoryImpl(
      crudNews: locator(),
      crudProfile: locator(),
      crudUmkm: locator(),
      crudTour: locator(),
      crudTrain: locator(),
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
  locator.registerLazySingleton<CrudTour>(
    () => CrudTourImpl(
      apiService: locator(),
    ),
  );
  locator.registerLazySingleton<CrudTrain>(
    () => CrudTrainImpl(
      apiService: locator(),
    ),
  );
}
