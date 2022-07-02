import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tourism/utils/failure.dart';

abstract class DataRepositoryFavTour {
  Future<Either<Failure, String>> addFavorite(
      double rating, String address, String tour, String urlName);
  Future<Either<Failure, String>> removeFavorite(DocumentReference index);
}
