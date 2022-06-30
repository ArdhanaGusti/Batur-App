import 'package:dartz/dartz.dart';
import 'package:umkm/data/utils/failure.dart';
import 'package:umkm/domain/repository/data_repository_umkm.dart';

class AddFavoriteUmkm {
  final DataRepositoryUmkm dataRepositoryUmkm;

  AddFavoriteUmkm(this.dataRepositoryUmkm);
  Future<Either<Failure, String>> execute(
      String username, String email, String umkm) {
    return dataRepositoryUmkm.addFavorite(username, email, umkm);
  }
}
