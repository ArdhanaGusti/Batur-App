import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transportation/domain/usecase/remove_train.dart';
import 'package:transportation/presentation/bloc/train/train_event.dart';
import 'package:transportation/presentation/bloc/train/train_state.dart';

class TrainRemoveBloc extends Bloc<TrainEvent, TrainState> {
  final RemoveTrain removeTrain;

  TrainRemoveBloc(this.removeTrain) : super(TrainEmpty()) {
    on<OnRemoveTrain>(
      (event, emit) async {
        emit(TrainLoading());
        final result = await removeTrain.execute(event.index);

        result.fold(
          (failure) {
            emit(TrainError(failure.message));
          },
          (data) {
            emit(TrainRemoved(data));
          },
        );
      },
    );
  }
}
