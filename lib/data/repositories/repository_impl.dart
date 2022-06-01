import 'package:capstone_design/data/sources/local_data_source.dart';
import 'package:capstone_design/domain/repositories/repository.dart';

class RepositoryImpl implements Repository {
  final LocalDataSource localDataSource;

  RepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<bool> isFirstOpen() async {
    final result = await localDataSource.isFirstOpen();

    return result;
  }
}
