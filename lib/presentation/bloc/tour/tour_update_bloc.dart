import 'package:capstone_design/domain/usecase/update_tour.dart';
import 'package:capstone_design/presentation/bloc/tour/tour_event.dart';
import 'package:capstone_design/presentation/bloc/tour/tour_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TourUpdateBloc extends Bloc<TourEvent, TourState> {
  final UpdateTour updateTour;

  TourUpdateBloc(this.updateTour) : super(TourEmpty()) {
    on<OnUpdateTour>(
      (event, emit) async {
        emit(TourLoading());
        final result = await updateTour.execute(
            event.context,
            event.image,
            event.coverUrlNow,
            event.imageName,
            event.name,
            event.type,
            event.desc,
            event.latitude,
            event.longitude,
            event.index);
        result.fold(
          (failure) {
            emit(TourError(failure.message));
          },
          (data) {
            emit(TourUpdated(data));
          },
        );
      },
    );
  }
}
