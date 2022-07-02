import 'package:umkm/domain/usecase/verif_umkm.dart';

import '../../domain/usecase/create_umkm.dart';
import '../../domain/usecase/update_umkm.dart';
import '../../../presentation/bloc/umkm_event.dart';
import '../../presentation/bloc/umkm_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UmkmUpdateBloc extends Bloc<UmkmEvent, UmkmState> {
  final UpdateUmkm updateUmkm;
  final VerifUmkm verifUmkm;

  UmkmUpdateBloc(this.updateUmkm, this.verifUmkm) : super(UmkmEmpty()) {
    on<OnUpdateUmkm>(
      (event, emit) async {
        emit(UmkmLoading());
        final result = await updateUmkm.execute(
            event.context,
            event.image,
            event.coverUrlNow,
            event.imageName,
            event.name,
            event.type,
            event.desc,
            event.latitude,
            event.longitude,
            event.address,
            event.phone,
            event.shopee,
            event.tokped,
            event.website,
            event.index);
        result.fold(
          (failure) {
            emit(UmkmError(failure.message));
          },
          (data) {
            emit(UmkmUpdated(data));
          },
        );
      },
    );

    on<OnVerifUmkm>(
      (event, emit) async {
        emit(UmkmLoading());
        final result = await verifUmkm.execute(event.index, event.value);
        result.fold(
          (failure) {
            emit(UmkmError(failure.message));
          },
          (data) {
            emit(UmkmUpdated(data));
          },
        );
      },
    );
  }
}
