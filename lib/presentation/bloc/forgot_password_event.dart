part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordFormEvent extends Equatable {
  const ForgotPasswordFormEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordFormEmailChanged extends ForgotPasswordFormEvent {
  final String email;
  const ForgotPasswordFormEmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class ForgotPasswordFormPasswordChanged extends ForgotPasswordFormEvent {
  final String password;
  const ForgotPasswordFormPasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

class ForgotPasswordFormPasswordConfChanged extends ForgotPasswordFormEvent {
  final String passwordConf;
  const ForgotPasswordFormPasswordConfChanged({required this.passwordConf});

  @override
  List<Object> get props => [passwordConf];
}
