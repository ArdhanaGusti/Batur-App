abstract class CoreRepository {
  Future<bool> isFirstOpen();
  Future<bool> isRememberMe();
  Future<bool> setRememberMe(bool value);
}
