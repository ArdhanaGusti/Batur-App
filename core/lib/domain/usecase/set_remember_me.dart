import 'package:core/domain/repositories/repositories.dart';

class SetRememberMe {
  final CoreRepository repository;

  SetRememberMe(this.repository);

  Future<bool> execute(bool value) async {
    return repository.setRememberMe(value);
  }
}
