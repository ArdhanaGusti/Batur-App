import 'package:core/data/sources/local_data_service.dart';
import 'package:core/domain/repositories/repositories.dart';

class CoreRepositoryImpl implements CoreRepository {
  final LocalDataSource localDataSource;

  CoreRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<bool> isFirstOpen() async {
    final result = await localDataSource.isFirstOpen();

    return result;
  }

  @override
  Future<bool> isRememberMe() async {
    final result = await localDataSource.isRememberMe();

    return result;
  }

  @override
  Future<bool> setRememberMe(bool value) async {
    final result = await localDataSource.setRememberMe(value);

    return result;
  }
}
