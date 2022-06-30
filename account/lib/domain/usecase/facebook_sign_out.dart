import 'package:account/domain/repository/data_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class FacebookSignOut {
  final DataAccountRepository repository;

  FacebookSignOut(this.repository);

  Future<Either<Failure, String>> execute() async {
    return repository.facebookSignOut();
  }
}
