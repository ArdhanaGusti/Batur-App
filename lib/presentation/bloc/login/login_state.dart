import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginEmpty extends LoginState {}

class LoginLoading extends LoginState {}

class LoginError extends LoginState {
  final String message;

  const LoginError(this.message);

  @override
  List<Object> get props => [message];
}

class LoginGoogleSuccess extends LoginState {
  final String result;

  const LoginGoogleSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class LoginEmailSuccess extends LoginState {
  final String result;

  const LoginEmailSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class LoginFacebookSuccess extends LoginState {
  final String result;

  const LoginFacebookSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class SignInEmailSuccess extends LoginState {
  final String result;

  const SignInEmailSuccess(this.result);

  @override
  List<Object> get props => [result];
}
