import 'package:account/domain/repository/data_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class DeleteAuth {
  final DataAccountRepository repository;

  DeleteAuth(this.repository);

  Future<Either<Failure, String>> execute() async {
    return repository.deleteAuth();
  }
}
