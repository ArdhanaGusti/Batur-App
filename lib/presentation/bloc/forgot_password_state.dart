part of 'forgot_password_bloc.dart';

class ForgotPasswordFormState extends Equatable {
  final String email;
  final String password;
  final String passwordConf;

  const ForgotPasswordFormState({
    required this.email,
    required this.password,
    required this.passwordConf,
  });

  ForgotPasswordFormState copyWith({
    String? email,
    String? password,
    String? passwordConf,
  }) {
    return ForgotPasswordFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConf: passwordConf ?? this.passwordConf,
    );
  }

  @override
  List<Object> get props => [
        email,
        password,
        passwordConf,
      ];
}

class ForgotPasswordInitial extends ForgotPasswordFormState {
  const ForgotPasswordInitial()
      : super(
          email: '',
          password: '',
          passwordConf: '',
        );
}
