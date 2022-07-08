import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourism/domain/usecase/add_favorite.dart';
import 'package:tourism/domain/usecase/remove_favorite.dart';
import 'package:tourism/presentation/bloc/favorite/favorite_event.dart';
import 'package:tourism/presentation/bloc/favorite/favorite_state.dart';

class FavoriteTourBloc extends Bloc<FavoriteTourEvent, FavoriteTourState> {
  final AddFavoriteTour addFavoriteUmkm;
  final RemoveFavoriteTour removeFavoriteUmkm;

  FavoriteTourBloc(this.addFavoriteUmkm, this.removeFavoriteUmkm)
      : super(FavoriteEmpty()) {
    on<OnAddFavorite>(
      (event, emit) async {
        emit(FavoriteLoading());
        final result = await addFavoriteUmkm.execute(
            event.rating, event.address, event.tour, event.urlName);

        result.fold(
          (failure) {
            emit(FavoriteError(failure.message));
          },
          (data) {
            emit(FavoriteTourAdd(data));
          },
        );
      },
    );
    on<OnRemoveFavorite>(
      (event, emit) async {
        emit(FavoriteLoading());
        final result = await removeFavoriteUmkm.execute(event.index);

        result.fold(
          (failure) {
            emit(FavoriteError(failure.message));
          },
          (data) {
            emit(FavoriteTourRemove(data));
          },
        );
      },
    );
  }
}
