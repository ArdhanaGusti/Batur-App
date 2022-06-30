import 'package:account/domain/repository/data_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class EmailSignUp {
  final DataAccountRepository repository;

  EmailSignUp(this.repository);

  Future<Either<Failure, String>> execute(
    String email,
    String password,
  ) async {
    return repository.emailSignUp(email, password);
  }
}
