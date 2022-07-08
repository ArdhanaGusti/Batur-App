import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class FavoriteTourEvent extends Equatable {
  const FavoriteTourEvent();

  @override
  List<Object> get props => [];
}

class OnAddFavorite extends FavoriteTourEvent {
  final String address, tour, urlName;
  final double rating;
  const OnAddFavorite(this.rating, this.tour, this.address, this.urlName);
  @override
  List<Object> get props => [];
}

class OnRemoveFavorite extends FavoriteTourEvent {
  final DocumentReference index;
  const OnRemoveFavorite(this.index);
  @override
  List<Object> get props => [];
}
