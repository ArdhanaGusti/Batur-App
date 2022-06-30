import 'package:account/domain/repository/data_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class EmailSignIn {
  final DataAccountRepository repository;

  EmailSignIn(this.repository);

  Future<Either<Failure, String>> execute(
    String email,
    String password,
  ) async {
    return repository.emailSignIn(email, password);
  }
}
