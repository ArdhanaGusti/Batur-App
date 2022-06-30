import 'package:umkm/data/datasources/crud_umkm.dart';
import 'package:umkm/data/utils/exception.dart';
import 'package:umkm/data/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:umkm/domain/repository/data_repository_umkm.dart';

class DataRepositoryUmkmImpl implements DataRepositoryUmkm {
  final CrudUmkmFav crudUmkmFav;

  DataRepositoryUmkmImpl({required this.crudUmkmFav});

  @override
  Future<Either<Failure, String>> addFavorite(
      String username, String email, String umkm) async {
    try {
      final res = await crudUmkmFav.addFavorite(username, email, umkm);
      return Right(res);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> removeFavorite(
      DocumentReference<Object?> index) async {
    try {
      final res = await crudUmkmFav.removeFavorite(index);
      return Right(res);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
