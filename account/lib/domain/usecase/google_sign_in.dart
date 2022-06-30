import 'package:account/domain/repository/data_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GoogleSignIn {
  final DataAccountRepository repository;

  GoogleSignIn(this.repository);

  Future<Either<Failure, String>> execute() async {
    return repository.googleSignIn();
  }
}
