import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelperAccount {
  static SharedPreferencesHelperAccount? _sharedpreferencesHelper;
  SharedPreferencesHelperAccount._instance() {
    _sharedpreferencesHelper = this;
  }

  factory SharedPreferencesHelperAccount() =>
      _sharedpreferencesHelper ?? SharedPreferencesHelperAccount._instance();

  static SharedPreferences? _preferences;

  Future<SharedPreferences?> get preferences async {
    _preferences ??= await _initDb();
    return _preferences;
  }

  static const String _isLogInPref = "isLogIn";

  Future<SharedPreferences> _initDb() async {
    final pref = await SharedPreferences.getInstance();
    return pref;
  }

  Future<bool> isLogIn() async {
    final pref = await preferences;

    final value = pref?.getBool(_isLogInPref) ?? false;

    return value;
  }

  Future<bool> saveIsLogIn(bool value) async {
    final pref = await preferences;

    pref?.setBool(_isLogInPref, value);

    final newValue = await isLogIn();

    if (value = newValue) {
      return true;
    } else {
      return false;
    }
  }
}
