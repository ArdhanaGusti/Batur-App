import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class OnAddFavorite extends FavoriteEvent {
  final String username, umkm, email;
  const OnAddFavorite(this.email, this.umkm, this.username);
  @override
  List<Object> get props => [];
}

class OnRemoveFavorite extends FavoriteEvent {
  final DocumentReference index;
  const OnRemoveFavorite(this.index);
  @override
  List<Object> get props => [];
}
