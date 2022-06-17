import 'package:capstone_design/domain/usecase/create_tour.dart';
import 'package:capstone_design/presentation/bloc/tour/tour_event.dart';
import 'package:capstone_design/presentation/bloc/tour/tour_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TourCreateBloc extends Bloc<TourEvent, TourState> {
  final CreateTour createTour;

  TourCreateBloc(this.createTour) : super(TourEmpty()) {
    on<OnCreateTour>(
      (event, emit) async {
        emit(TourLoading());
        final result = await createTour.execute(
            event.context,
            event.imageName,
            event.name,
            event.type,
            event.desc,
            event.image,
            event.currentLocation);

        result.fold(
          (failure) {
            emit(TourError(failure.message));
          },
          (data) {
            emit(TourCreated(data));
          },
        );
      },
    );
  }
}
