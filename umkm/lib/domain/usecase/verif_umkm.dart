import '../../domain/repository/data_repository.dart';
import '../../utils/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class VerifUmkm {
  final DataRepositoryUmkm repository;

  VerifUmkm(this.repository);

  Future<Either<Failure, String>> execute(
      DocumentReference<Object?> index, bool value) {
    return repository.verif(index, value);
  }
}
