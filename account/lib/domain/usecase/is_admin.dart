import 'package:account/domain/repository/data_repository.dart';

class IsAdmin {
  final DataAccountRepository repository;

  IsAdmin(this.repository);

  Future<bool> execute(String email) async {
    return repository.isAdmin(email);
  }
}
