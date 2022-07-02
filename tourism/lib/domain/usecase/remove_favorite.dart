import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tourism/domain/repository/data_repository.dart';
import 'package:tourism/utils/failure.dart';

class RemoveFavoriteTour {
  final DataRepositoryFavTour repository;

  RemoveFavoriteTour(this.repository);

  Future<Either<Failure, String>> execute(DocumentReference index) {
    return repository.removeFavorite(index);
  }
}
