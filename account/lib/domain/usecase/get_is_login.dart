import 'package:account/domain/repository/data_repository.dart';

class GetIsLogIn {
  final DataAccountRepository repository;

  GetIsLogIn(this.repository);

  Future<bool> execute() async {
    return repository.isLogIn();
  }
}
