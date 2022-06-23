part of 'regis_form_bloc.dart';

class RegisFormState extends Equatable {
  final String email;
  final String password;
  final String passwordConf;
  final String username;
  final String fullName;
  final String message;
  final bool isVerif;
  final bool obsecurePassword;
  final bool obsecurePasswordConf;
  final FormStatusEnum formStatus;

  const RegisFormState({
    required this.email,
    required this.password,
    required this.passwordConf,
    required this.username,
    required this.fullName,
    required this.message,
    required this.isVerif,
    required this.obsecurePassword,
    required this.obsecurePasswordConf,
    required this.formStatus,
  });

  RegisFormState copyWith({
    String? email,
    String? password,
    String? passwordConf,
    String? username,
    String? fullName,
    String? message,
    bool? isVerif,
    bool? obsecurePassword,
    bool? obsecurePasswordConf,
    FormStatusEnum? formStatus,
  }) {
    return RegisFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConf: passwordConf ?? this.passwordConf,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      message: message ?? this.message,
      isVerif: isVerif ?? this.isVerif,
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
        isVerif,
        username,
        fullName,
        message,
        formStatus,
        obsecurePasswordConf,
        obsecurePassword,
      ];
}

class RegisFormInitial extends RegisFormState {
  static String emailInit = '';
  static String passwordInit = '';
  static String passwordConfInit = '';
  static String usernameInit = '';
  static String fullNameInit = '';
  static String messageInit = '';
  static bool isVerifInit = false;
  static bool obsecurePasswordInit = true;
  static bool obsecurePasswordConfInit = true;
  static FormStatusEnum formStatusInit = FormStatusEnum.initForm;

  RegisFormInitial()
      : super(
          email: emailInit,
          password: passwordInit,
          passwordConf: passwordConfInit,
          username: usernameInit,
          fullName: fullNameInit,
          message: messageInit,
          isVerif: isVerifInit,
          obsecurePassword: obsecurePasswordInit,
          obsecurePasswordConf: obsecurePasswordConfInit,
          formStatus: formStatusInit,
        );
}
