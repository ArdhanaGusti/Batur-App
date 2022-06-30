import 'package:account/domain/repository/data_repository.dart';

class IsHaveProfile {
  final DataAccountRepository repository;

  IsHaveProfile(this.repository);

  Future<bool> execute(String email) async {
    return repository.isHaveProfile(email);
  }
}
