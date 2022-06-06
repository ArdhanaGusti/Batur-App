part of 'forgot_password_bloc.dart';

class ForgotPasswordFormState extends Equatable {
  final String email;
  final String password;
  final String passwordConf;
  final bool obsecurePassword;
  final bool obsecurePasswordConf;
  final FormStatusEnum formStatus;

  const ForgotPasswordFormState({
    required this.email,
    required this.password,
    required this.passwordConf,
    required this.obsecurePassword,
    required this.obsecurePasswordConf,
    required this.formStatus,
  });

  ForgotPasswordFormState copyWith({
    String? email,
    String? password,
    String? passwordConf,
    bool? obsecurePassword,
    bool? obsecurePasswordConf,
    FormStatusEnum? formStatus,
  }) {
    return ForgotPasswordFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConf: passwordConf ?? this.passwordConf,
      formStatus: formStatus ?? this.formStatus,
      obsecurePassword: obsecurePassword ?? this.obsecurePassword,
      obsecurePasswordConf: obsecurePasswordConf ?? this.obsecurePasswordConf,
    );
  }

  @override
  List<Object> get props => [
        email,
        password,
        passwordConf,
        formStatus,
        obsecurePasswordConf,
        obsecurePassword,
      ];
}

class ForgotPasswordInitial extends ForgotPasswordFormState {
  const ForgotPasswordInitial()
      : super(
          email: '',
          password: '',
          passwordConf: '',
          obsecurePassword: true,
          obsecurePasswordConf: true,
          formStatus: FormStatusEnum.initForm,
        );
}
