part of 'login_form_bloc.dart';

class LoginFormState extends Equatable {
  final String email;
  final String password;
  final String message;
  final bool isVerif;
  final bool obsecurePassword;
  final bool rememberMe;
  final FormStatusEnum formStatus;

  const LoginFormState({
    required this.email,
    required this.password,
    required this.message,
    required this.isVerif,
    required this.obsecurePassword,
    required this.rememberMe,
    required this.formStatus,
  });

  LoginFormState copyWith({
    String? email,
    String? password,
    String? message,
    bool? isVerif,
    bool? obsecurePassword,
    bool? rememberMe,
    FormStatusEnum? formStatus,
  }) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      message: message ?? this.message,
      isVerif: isVerif ?? this.isVerif,
      formStatus: formStatus ?? this.formStatus,
      obsecurePassword: obsecurePassword ?? this.obsecurePassword,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }

  @override
  List<Object> get props => [
        email,
        password,
        isVerif,
        message,
        formStatus,
        rememberMe,
        obsecurePassword
      ];
}

class LoginFormInitial extends LoginFormState {
  static String emailInit = '';
  static String passwordInit = '';
  static String messageInit = '';
  static bool isVerifInit = false;
  static bool obsecurePasswordInit = true;
  static bool rememberMeInit = false;
  static FormStatusEnum formStatusInit = FormStatusEnum.initForm;

  LoginFormInitial()
      : super(
          email: emailInit,
          password: passwordInit,
          message: messageInit,
          isVerif: isVerifInit,
          obsecurePassword: obsecurePasswordInit,
          rememberMe: rememberMeInit,
          formStatus: formStatusInit,
        );
}
