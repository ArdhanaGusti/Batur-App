import 'package:equatable/equatable.dart';

abstract class TourState extends Equatable {
  const TourState();

  @override
  List<Object> get props => [];
}

class TourEmpty extends TourState {}

class TourLoading extends TourState {}

class TourError extends TourState {
  final String message;

  const TourError(this.message);

  @override
  List<Object> get props => [message];
}

class TourCreated extends TourState {
  final String result;

  const TourCreated(this.result);

  @override
  List<Object> get props => [result];
}

class TourUpdated extends TourState {
  final String result;

  const TourUpdated(this.result);

  @override
  List<Object> get props => [result];
}

class TourRemoved extends TourState {
  final String result;

  const TourRemoved(this.result);

  @override
  List<Object> get props => [result];
}
