import 'package:equatable/equatable.dart';

abstract class FavoriteTourState extends Equatable {
  const FavoriteTourState();

  @override
  List<Object> get props => [];
}

class FavoriteEmpty extends FavoriteTourState {}

class FavoriteLoading extends FavoriteTourState {}

class FavoriteError extends FavoriteTourState {
  final String message;

  const FavoriteError(this.message);

  @override
  List<Object> get props => [message];
}

class FavoriteTourAdd extends FavoriteTourState {
  final String result;

  const FavoriteTourAdd(this.result);

  @override
  List<Object> get props => [result];
}

class FavoriteTourRemove extends FavoriteTourState {
  final String result;

  const FavoriteTourRemove(this.result);

  @override
  List<Object> get props => [result];
}
