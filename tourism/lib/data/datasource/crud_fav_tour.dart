import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tourism/data/service/api_service_tour.dart';
import 'package:tourism/utils/exception.dart';

abstract class CrudFavTour {
  Future<String> addFavorite(
      double rating, String address, String tour, String urlName);
  Future<String> removeFavorite(DocumentReference index);
}

class CrudFavTourImpl implements CrudFavTour {
  final ApiServiceTour apiServiceTour;

  CrudFavTourImpl({required this.apiServiceTour});

  @override
  Future<String> addFavorite(
      double rating, String address, String tour, String urlName) async {
    try {
      apiServiceTour.addFavorite(rating, address, tour, urlName);
      return 'Umkm $tour berhasil ditambahakan';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeFavorite(DocumentReference<Object?> index) async {
    try {
      apiServiceTour.removeFavorite(index);
      return 'Data umkm berhasil dihapus';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
