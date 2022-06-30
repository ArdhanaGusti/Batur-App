import '../../domain/repository/data_repository.dart';
import '../../utils/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class RemoveUmkm {
  final DataRepositoryUmkm repository;

  RemoveUmkm(this.repository);

  Future<Either<Failure, String>> execute(
      DocumentReference<Object?> index, String coverUrl) {
    return repository.removeUmkm(index, coverUrl);
  }
}
