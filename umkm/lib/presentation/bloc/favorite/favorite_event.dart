import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class OnAddFavorite extends FavoriteEvent {
  final String address, seller, urlName, email, umkm;
  const OnAddFavorite(
      this.email, this.umkm, this.address, this.seller, this.urlName);
  @override
  List<Object> get props => [];
}

class OnRemoveFavorite extends FavoriteEvent {
  final DocumentReference index;
  const OnRemoveFavorite(this.index);
  @override
  List<Object> get props => [];
}
