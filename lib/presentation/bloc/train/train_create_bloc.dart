import 'package:capstone_design/domain/usecase/create_train.dart';
import 'package:capstone_design/presentation/bloc/train/train_event.dart';
import 'package:capstone_design/presentation/bloc/train/train_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainCreateBloc extends Bloc<TrainEvent, TrainState> {
  final CreateTrain createTrain;

  TrainCreateBloc(this.createTrain) : super(TrainEmpty()) {
    on<OnCreateTrain>(
      (event, emit) async {
        emit(TrainLoading());
        final result = await createTrain.execute(
            event.context, event.trainName, event.station, event.time);

        result.fold(
          (failure) {
            emit(TrainError(failure.message));
          },
          (data) {
            emit(TrainCreated(data));
          },
        );
      },
    );
  }
}
