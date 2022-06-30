import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:umkm/data/utils/failure.dart';

abstract class DataRepositoryUmkm {
  Future<Either<Failure, String>> addFavorite(
      String username, String email, String umkm);
  Future<Either<Failure, String>> removeFavorite(DocumentReference index);
}
