import 'package:dartz/dartz.dart';
import '../../utils/failure.dart';

import '../repository/data_repository.dart';

class AddFavoriteUmkm {
  final DataRepositoryUmkm dataRepositoryUmkm;

  AddFavoriteUmkm(this.dataRepositoryUmkm);
  Future<Either<Failure, String>> execute(String address, String seller,
      String urlName, String email, String umkm) {
    return dataRepositoryUmkm.addFavorite(
        address, seller, urlName, email, umkm);
  }
}
