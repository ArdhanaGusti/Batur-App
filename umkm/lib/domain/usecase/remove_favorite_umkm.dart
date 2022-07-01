import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:umkm/domain/repository/data_repository.dart';
import 'package:umkm/utils/failure.dart';

class RemoveFavoriteUmkm {
  final DataRepositoryUmkm dataRepositoryUmkm;

  RemoveFavoriteUmkm(this.dataRepositoryUmkm);
  Future<Either<Failure, String>> execute(DocumentReference index) {
    return dataRepositoryUmkm.removeFavorite(index);
  }
}
