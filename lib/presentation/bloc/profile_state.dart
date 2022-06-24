part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final String email;
  final String password;
  final String passwordConf;
  final String username;
  final String fullName;
  final String message;
  final FormStatusEnum formStatus;

  const ProfileState({
    required this.email,
    required this.password,
    required this.passwordConf,
    required this.username,
    required this.fullName,
    required this.message,
    required this.formStatus,
  });

  ProfileState copyWith({
    String? email,
    String? password,
    String? passwordConf,
    String? username,
    String? fullName,
    String? message,
    FormStatusEnum? formStatus,
  }) {
    return ProfileState(
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConf: passwordConf ?? this.passwordConf,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      message: message ?? this.message,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  List<Object> get props => [
        email,
        password,
        passwordConf,
        username,
        fullName,
        message,
        formStatus,
      ];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial()
      : super(
          email: "",
          password: "",
          passwordConf: "",
          username: "",
          fullName: "",
          message: "",
          formStatus: FormStatusEnum.initForm,
        );
}
