import 'package:equatable/equatable.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteEmpty extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteError extends FavoriteState {
  final String message;

  const FavoriteError(this.message);

  @override
  List<Object> get props => [message];
}

class FavoriteAdd extends FavoriteState {
  final String result;

  const FavoriteAdd(this.result);

  @override
  List<Object> get props => [result];
}

class FavoriteRemove extends FavoriteState {
  final String result;

  const FavoriteRemove(this.result);

  @override
  List<Object> get props => [result];
}
