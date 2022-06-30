import '../../../../domain/usecase/create_umkm.dart';
import '../../presentation/bloc/umkm_event.dart';
import '../../presentation/bloc/umkm_state.dart';
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
            event.address,
            event.phone,
            event.shopee,
            event.tokped,
            event.website,
            event.name,
            event.type,
            event.desc,
            event.image,
            event.latitude,
            event.longitude);

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
