import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umkm/domain/usecase/add_favorite_umkm.dart';
import 'package:umkm/domain/usecase/remove_favorite_umkm.dart';
import 'package:umkm/presentation/bloc/favorite/favorite_event.dart';
import 'package:umkm/presentation/bloc/favorite/favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final AddFavoriteUmkm addFavoriteUmkm;
  final RemoveFavoriteUmkm removeFavoriteUmkm;

  FavoriteBloc(this.addFavoriteUmkm, this.removeFavoriteUmkm)
      : super(FavoriteEmpty()) {
    on<OnAddFavorite>(
      (event, emit) async {
        emit(FavoriteLoading());
        final result = await addFavoriteUmkm.execute(event.address,
            event.seller, event.urlName, event.email, event.umkm);

        result.fold(
          (failure) {
            emit(FavoriteError(failure.message));
          },
          (data) {
            emit(FavoriteAdd(data));
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
            emit(FavoriteRemove(data));
          },
        );
      },
    );
  }
}
