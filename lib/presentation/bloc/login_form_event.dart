part of 'login_form_bloc.dart';

abstract class LoginFormEvent extends Equatable {
  const LoginFormEvent();

  @override
  List<Object> get props => [];
}

class LoginFormEmailChanged extends LoginFormEvent {
  final String email;
  const LoginFormEmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class LoginFormPasswordChanged extends LoginFormEvent {
  final String password;
  const LoginFormPasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

class LoginFormObsecurePasswordChanged extends LoginFormEvent {
  final bool obsecure;
  const LoginFormObsecurePasswordChanged({required this.obsecure});

  @override
  List<Object> get props => [obsecure];
}

class LoginFormRememberMeChanged extends LoginFormEvent {
  final bool rememberMe;
  const LoginFormRememberMeChanged({required this.rememberMe});

  @override
  List<Object> get props => [rememberMe];
}
