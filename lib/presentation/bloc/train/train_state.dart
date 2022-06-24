import 'package:equatable/equatable.dart';

abstract class TrainState extends Equatable {
  const TrainState();

  @override
  List<Object> get props => [];
}

class TrainEmpty extends TrainState {}

class TrainLoading extends TrainState {}

class TrainError extends TrainState {
  final String message;

  const TrainError(this.message);

  @override
  List<Object> get props => [message];
}

class TrainCreated extends TrainState {
  final String result;

  const TrainCreated(this.result);

  @override
  List<Object> get props => [result];
}

class TrainUpdated extends TrainState {
  final String result;

  const TrainUpdated(this.result);

  @override
  List<Object> get props => [result];
}

class TrainRemoved extends TrainState {
  final String result;

  const TrainRemoved(this.result);

  @override
  List<Object> get props => [result];
}
