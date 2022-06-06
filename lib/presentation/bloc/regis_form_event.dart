part of 'regis_form_bloc.dart';

abstract class RegisFormEvent extends Equatable {
  const RegisFormEvent();

  @override
  List<Object> get props => [];
}

class RegisFormEmailChanged extends RegisFormEvent {
  final String email;
  const RegisFormEmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class RegisFormPasswordChanged extends RegisFormEvent {
  final String password;
  const RegisFormPasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

class RegisFormPasswordConfChanged extends RegisFormEvent {
  final String passwordConf;
  const RegisFormPasswordConfChanged({required this.passwordConf});

  @override
  List<Object> get props => [passwordConf];
}

class RegisFormObsecurePasswordChanged extends RegisFormEvent {
  final bool obsecure;
  const RegisFormObsecurePasswordChanged({required this.obsecure});

  @override
  List<Object> get props => [obsecure];
}

class RegisFormObsecurePasswordConfChanged extends RegisFormEvent {
  final bool obsecureConf;
  const RegisFormObsecurePasswordConfChanged({required this.obsecureConf});

  @override
  List<Object> get props => [obsecureConf];
}

class RegisFormUsernameChanged extends RegisFormEvent {
  final String username;
  const RegisFormUsernameChanged({required this.username});

  @override
  List<Object> get props => [username];
}

class RegisFormFullNameChanged extends RegisFormEvent {
  final String fullName;
  const RegisFormFullNameChanged({required this.fullName});

  @override
  List<Object> get props => [fullName];
}
