import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferencesHelper? _sharedpreferencesHelper;
  SharedPreferencesHelper._instance() {
    _sharedpreferencesHelper = this;
  }

  factory SharedPreferencesHelper() =>
      _sharedpreferencesHelper ?? SharedPreferencesHelper._instance();

  static SharedPreferences? _preferences;

  Future<SharedPreferences?> get preferences async {
    _preferences ??= await _initDb();
    return _preferences;
  }

  static const String _isFirstPref = 'isFirstTimeOpen';
  static const String _isRememberPref = 'isRememberMe';

  Future<SharedPreferences> _initDb() async {
    final pref = await SharedPreferences.getInstance();
    return pref;
  }

  Future<bool> isFirstOpen() async {
    final pref = await preferences;

    final value = pref?.getBool(_isFirstPref) ?? true;

    if (value) {
      pref?.setBool(_isFirstPref, false);
      return value;
    } else {
      return false;
    }
  }

  Future<bool> isRememberMe() async {
    final pref = await preferences;

    final value = pref?.getBool(_isRememberPref) ?? false;

    return value;
  }

  Future<bool> setRememberMe(bool remember) async {
    final pref = await preferences;

    final value = await pref!.setBool(_isRememberPref, remember);

    return value;
  }
}
