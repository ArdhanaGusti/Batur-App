import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:theme/common/failure.dart';
import 'package:transportation/domain/repository/data_repository_trans.dart';

class RemoveTrain {
  final DataRepositoryTrans repository;

  RemoveTrain(this.repository);

  Future<Either<Failure, String>> execute(DocumentReference<Object?> index) {
    return repository.removeTrain(index);
  }
}
