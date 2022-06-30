import 'package:account/data/helper/shared_preferences_helper.dart';

abstract class AccountLocalDataSource {
  Future<bool> isLogIn();
  Future<bool> saveIsLogIn(bool value);
}

class AccountLocalDataSourceImpl implements AccountLocalDataSource {
  final SharedPreferencesHelperAccount databaseHelper;

  AccountLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<bool> isLogIn() async {
    return await databaseHelper.isLogIn();
  }

  @override
  Future<bool> saveIsLogIn(bool value) async {
    return await databaseHelper.saveIsLogIn(value);
  }
}
