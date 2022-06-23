part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileFormEmailChanged extends ProfileEvent {
  final String email;
  const ProfileFormEmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class ProfileFormPasswordChanged extends ProfileEvent {
  final String password;
  const ProfileFormPasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

class ProfileFormPasswordConfChanged extends ProfileEvent {
  final String passwordConf;
  const ProfileFormPasswordConfChanged({required this.passwordConf});

  @override
  List<Object> get props => [passwordConf];
}

class ProfileFormUsernameChanged extends ProfileEvent {
  final String username;
  const ProfileFormUsernameChanged({required this.username});

  @override
  List<Object> get props => [username];
}

class ProfileFormFullNameChanged extends ProfileEvent {
  final String fullName;
  const ProfileFormFullNameChanged({required this.fullName});

  @override
  List<Object> get props => [fullName];
}
