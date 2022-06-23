import 'package:capstone_design/data/sources/shared_preferences_helper.dart';

abstract class LocalDataSource {
  Future<bool> isFirstOpen();
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferencesHelper databaseHelper;

  LocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<bool> isFirstOpen() async {
    return await databaseHelper.isFirstOpen();
  }
}
