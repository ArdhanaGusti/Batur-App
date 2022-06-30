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

class RegisFormRememberMeChanged extends RegisFormEvent {
  final bool rememberMe;
  const RegisFormRememberMeChanged({required this.rememberMe});

  @override
  List<Object> get props => [rememberMe];
}

class OnEmailSignUp extends RegisFormEvent {
  const OnEmailSignUp();
  @override
  List<Object> get props => [];
}

class OnGoogleSignUp extends RegisFormEvent {
  const OnGoogleSignUp();
  @override
  List<Object> get props => [];
}

class OnFacebookSignUp extends RegisFormEvent {
  const OnFacebookSignUp();
  @override
  List<Object> get props => [];
}

class OnDeleteAuth extends RegisFormEvent {
  const OnDeleteAuth();
  @override
  List<Object> get props => [];
}

class OnSignUp extends RegisFormEvent {
  final String imageName;
  final File image;
  const OnSignUp(this.image, this.imageName);

  @override
  List<Object> get props => [image, imageName];
}
