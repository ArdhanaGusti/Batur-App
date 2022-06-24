import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileEmpty extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}

class ProfileCreated extends ProfileState {
  final String result;

  const ProfileCreated(this.result);

  @override
  List<Object> get props => [result];
}

class ProfileUpdated extends ProfileState {
  final String result;

  const ProfileUpdated(this.result);

  @override
  List<Object> get props => [result];
}
