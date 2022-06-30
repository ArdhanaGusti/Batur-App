import 'package:core/data/helper/shared_preferences_helper.dart';

abstract class LocalDataSource {
  Future<bool> isFirstOpen();
  Future<bool> isRememberMe();
  Future<bool> setRememberMe(bool value);
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferencesHelper databaseHelper;

  LocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<bool> isFirstOpen() async {
    return await databaseHelper.isFirstOpen();
  }

  @override
  Future<bool> isRememberMe() async {
    return await databaseHelper.isRememberMe();
  }

  @override
  Future<bool> setRememberMe(bool value) async {
    return await databaseHelper.setRememberMe(value);
  }
}
