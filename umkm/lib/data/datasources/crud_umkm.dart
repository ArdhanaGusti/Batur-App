import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:umkm/data/service/api_service_umkm.dart';
import 'package:umkm/data/utils/exception.dart';

abstract class CrudUmkmFav {
  Future<String> addFavorite(String username, String email, String umkm);
  Future<String> removeFavorite(DocumentReference index);
}

class CrudUmkmFavImpl implements CrudUmkmFav {
  final ApiServiceUmkm apiServiceUmkm;

  CrudUmkmFavImpl({required this.apiServiceUmkm});

  @override
  Future<String> addFavorite(String username, String email, String umkm) async {
    try {
      apiServiceUmkm.addFavorite(username, email, umkm);
      return "Telah ditambahkan di favorit";
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeFavorite(DocumentReference<Object?> index) async {
    try {
      apiServiceUmkm.removeFavorite(index);
      return "Telah dihapus dari favorit";
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
