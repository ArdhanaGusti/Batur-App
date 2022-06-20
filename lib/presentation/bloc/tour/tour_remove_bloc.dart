import 'package:capstone_design/domain/usecase/remove_tour.dart';
import 'package:capstone_design/presentation/bloc/tour/tour_event.dart';
import 'package:capstone_design/presentation/bloc/tour/tour_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TourRemoveBloc extends Bloc<TourEvent, TourState> {
  final RemoveTour removeTour;

  TourRemoveBloc(this.removeTour) : super(TourEmpty()) {
    on<OnRemoveTour>(
      (event, emit) async {
        emit(TourLoading());
        final result = await removeTour.execute(event.index, event.coverUrl);

        result.fold(
          (failure) {
            emit(TourError(failure.message));
          },
          (data) {
            emit(TourRemoved(data));
          },
        );
      },
    );
  }
}
