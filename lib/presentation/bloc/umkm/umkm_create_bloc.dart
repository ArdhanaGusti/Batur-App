import 'package:capstone_design/domain/usecase/create_umkm.dart';
import 'package:capstone_design/presentation/bloc/umkm/umkm_event.dart';
import 'package:capstone_design/presentation/bloc/umkm/umkm_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UmkmCreateBloc extends Bloc<UmkmEvent, UmkmState> {
  final CreateUmkm createUmkm;

  UmkmCreateBloc(this.createUmkm) : super(UmkmEmpty()) {
    on<OnCreateUmkm>(
      (event, emit) async {
        emit(UmkmLoading());
        final result = await createUmkm.execute(
            event.context,
            event.imageName,
            event.name,
            event.type,
            event.desc,
            event.image,
            event.currentLocation);

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
