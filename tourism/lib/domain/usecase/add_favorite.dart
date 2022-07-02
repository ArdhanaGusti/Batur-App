import 'package:dartz/dartz.dart';
import 'package:tourism/domain/repository/data_repository.dart';
import 'package:tourism/utils/failure.dart';

class AddFavoriteTour {
  final DataRepositoryFavTour repository;

  AddFavoriteTour(this.repository);

  Future<Either<Failure, String>> execute(
      double rating, String address, String tour, String urlName) {
    return repository.addFavorite(rating, address, tour, urlName);
  }
}
