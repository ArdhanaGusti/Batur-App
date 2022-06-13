import 'package:capstone_design/domain/usecase/create_umkm.dart';
import 'package:capstone_design/domain/usecase/update_umkm.dart';
import 'package:capstone_design/presentation/bloc/umkm/umkm_event.dart';
import 'package:capstone_design/presentation/bloc/umkm/umkm_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UmkmUpdateBloc extends Bloc<UmkmEvent, UmkmState> {
  final UpdateUmkm updateUmkm;

  UmkmUpdateBloc(this.updateUmkm) : super(UmkmEmpty()) {
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
            event.center,
            event.index);
        result.fold(
          (failure) {
            emit(UmkmError(failure.message));
          },
          (data) {
            emit(UmkmCreated(data));
          },
        );
      },
    );
  }
}
