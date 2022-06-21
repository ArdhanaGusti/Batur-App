import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class OnLoginGoogle extends LoginEvent {
  final BuildContext context;

  const OnLoginGoogle(this.context);
  @override
  List<Object> get props => [];
}

class OnLoginFacebook extends LoginEvent {
  final BuildContext context;

  const OnLoginFacebook(this.context);
  @override
  List<Object> get props => [];
}

class OnSignInEmail extends LoginEvent {
  final BuildContext context;
  final String email;
  final String pass;

  const OnSignInEmail(this.context, this.email, this.pass);
  @override
  List<Object> get props => [];
}

class OnLoginEmail extends LoginEvent {
  final BuildContext context;
  final String email;
  final String pass;

  const OnLoginEmail(this.context, this.email, this.pass);
  @override
  List<Object> get props => [];
}
