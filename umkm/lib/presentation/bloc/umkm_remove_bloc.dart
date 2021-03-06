import '../../domain/usecase/remove_umkm.dart';
import '../../presentation/bloc/umkm_event.dart';
import '../../presentation/bloc/umkm_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UmkmRemoveBloc extends Bloc<UmkmEvent, UmkmState> {
  final RemoveUmkm removeUmkm;

  UmkmRemoveBloc(this.removeUmkm) : super(UmkmEmpty()) {
    on<OnRemoveUmkm>(
      (event, emit) async {
        emit(UmkmLoading());
        final result = await removeUmkm.execute(event.index, event.coverUrl);

        result.fold(
          (failure) {
            emit(UmkmError(failure.message));
          },
          (data) {
            emit(UmkmRemoved(data));
          },
        );
      },
    );
  }
}
