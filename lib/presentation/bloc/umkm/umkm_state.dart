import 'package:equatable/equatable.dart';

abstract class UmkmState extends Equatable {
  const UmkmState();

  @override
  List<Object> get props => [];
}

class UmkmEmpty extends UmkmState {}

class UmkmLoading extends UmkmState {}

class UmkmError extends UmkmState {
  final String message;

  const UmkmError(this.message);

  @override
  List<Object> get props => [message];
}

class UmkmCreated extends UmkmState {
  final String result;

  const UmkmCreated(this.result);

  @override
  List<Object> get props => [result];
}

class UmkmUpdated extends UmkmState {
  final String result;

  const UmkmUpdated(this.result);

  @override
  List<Object> get props => [result];
}
