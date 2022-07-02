import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tourism/data/datasource/crud_fav_tour.dart';
import 'package:tourism/domain/repository/data_repository.dart';
import 'package:tourism/utils/exception.dart';
import 'package:tourism/utils/failure.dart';

class DataRepositoryFavTourImpl implements DataRepositoryFavTour {
  final CrudFavTour crudFavTour;

  DataRepositoryFavTourImpl({required this.crudFavTour});
  @override
  Future<Either<Failure, String>> addFavorite(
      double rating, String address, String tour, String urlName) async {
    try {
      final res = await crudFavTour.addFavorite(rating, address, tour, urlName);
      return Right(res);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> removeFavorite(
      DocumentReference index) async {
    try {
      final res = await crudFavTour.removeFavorite(index);
      return Right(res);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
