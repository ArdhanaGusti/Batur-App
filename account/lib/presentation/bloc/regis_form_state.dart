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
  final bool rememberMe;
  final FormStatusEnum formStatus;
  final String imageName;
  final File image;
  User? user;
  final bool isGoogle;
  final bool isEmail;
  final bool isFacebook;

  RegisFormState({
    required this.email,
    required this.password,
    required this.passwordConf,
    required this.username,
    required this.fullName,
    required this.message,
    required this.isVerif,
    required this.rememberMe,
    required this.obsecurePassword,
    required this.obsecurePasswordConf,
    required this.formStatus,
    required this.image,
    required this.imageName,
    required this.isEmail,
    required this.isGoogle,
    required this.isFacebook,
    this.user,
  });

  RegisFormState copyWith({
    String? email,
    String? password,
    String? passwordConf,
    String? username,
    String? fullName,
    String? message,
    String? imageName,
    bool? isVerif,
    bool? rememberMe,
    bool? obsecurePassword,
    bool? obsecurePasswordConf,
    bool? isEmail,
    bool? isGoogle,
    bool? isFacebook,
    File? image,
    User? user,
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
      rememberMe: rememberMe ?? this.rememberMe,
      formStatus: formStatus ?? this.formStatus,
      obsecurePassword: obsecurePassword ?? this.obsecurePassword,
      obsecurePasswordConf: obsecurePasswordConf ?? this.obsecurePasswordConf,
      imageName: imageName ?? this.imageName,
      image: image ?? this.image,
      isGoogle: isGoogle ?? this.isGoogle,
      isEmail: isEmail ?? this.isEmail,
      isFacebook: isFacebook ?? this.isFacebook,
      user: user,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        passwordConf,
        isVerif,
        rememberMe,
        username,
        fullName,
        message,
        formStatus,
        obsecurePasswordConf,
        obsecurePassword,
        imageName,
        image,
        isEmail,
        isFacebook,
        isGoogle,
        user,
      ];
}

class RegisFormInitial extends RegisFormState {
  static String emailInit = '';
  static String passwordInit = '';
  static String passwordConfInit = '';
  static String usernameInit = '';
  static String fullNameInit = '';
  static String messageInit = '';
  static String imageNameInit = '';
  static bool isVerifInit = false;
  static bool rememberMeInit = false;
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
          image: File('file.jpg'),
          rememberMe: false,
          isEmail: false,
          isFacebook: false,
          isGoogle: false,
          imageName: imageNameInit,
          user: null,
        );
}
