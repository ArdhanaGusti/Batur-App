import 'package:core/domain/repositories/repositories.dart';

class GetRememberMe {
  final CoreRepository repository;

  GetRememberMe(this.repository);

  Future<bool> execute() async {
    return repository.isRememberMe();
  }
}
