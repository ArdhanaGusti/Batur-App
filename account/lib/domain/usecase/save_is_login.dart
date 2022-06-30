import 'package:account/domain/repository/data_repository.dart';

class SaveIsLogIn {
  final DataAccountRepository repository;

  SaveIsLogIn(this.repository);

  Future<bool> execute(bool value) async {
    return repository.saveIsLogIn(value);
  }
}
