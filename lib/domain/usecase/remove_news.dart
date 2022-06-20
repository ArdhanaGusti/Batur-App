import 'package:capstone_design/domain/repository/data_repository.dart';
import 'package:capstone_design/utils/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class RemoveNews {
  final DataRepository repository;

  RemoveNews(this.repository);

  Future<Either<Failure, String>> execute(
      DocumentReference<Object?> index, String coverUrl) {
    return repository.removeNews(index, coverUrl);
  }
}
