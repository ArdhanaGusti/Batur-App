import 'package:equatable/equatable.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsEmpty extends NewsState {}

class NewsLoading extends NewsState {}

class NewsError extends NewsState {
  final String message;

  const NewsError(this.message);

  @override
  List<Object> get props => [message];
}

class NewsCreated extends NewsState {
  final String result;

  const NewsCreated(this.result);

  @override
  List<Object> get props => [result];
}

class NewsUpdated extends NewsState {
  final String result;

  const NewsUpdated(this.result);

  @override
  List<Object> get props => [result];
}
