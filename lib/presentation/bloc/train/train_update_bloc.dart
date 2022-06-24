import 'package:capstone_design/domain/usecase/update_train.dart';
import 'package:capstone_design/presentation/bloc/train/train_event.dart';
import 'package:capstone_design/presentation/bloc/train/train_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainUpdateBloc extends Bloc<TrainEvent, TrainState> {
  final UpdateTrain updateTrain;

  TrainUpdateBloc(this.updateTrain) : super(TrainEmpty()) {
    on<OnUpdateTrain>(
      (event, emit) async {
        emit(TrainLoading());
        final result = await updateTrain.execute(event.context, event.trainName,
            event.station, event.time, event.index);
        result.fold(
          (failure) {
            emit(TrainError(failure.message));
          },
          (data) {
            emit(TrainUpdated(data));
          },
        );
      },
    );
  }
}
