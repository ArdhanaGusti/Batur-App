part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final String email;
  final String password;
  final String passwordConf;
  final String username;
  final String fullName;
  final String message;
  final FormStatusEnum formStatus;
  final File? image;
  final String? imageName;
  final String imageUrl;
  final DocumentReference? id;

  const ProfileState({
    required this.email,
    required this.password,
    required this.passwordConf,
    required this.username,
    required this.fullName,
    required this.message,
    required this.formStatus,
    required this.image,
    required this.imageName,
    required this.imageUrl,
    required this.id,
  });

  ProfileState copyWith({
    String? email,
    String? password,
    String? passwordConf,
    String? username,
    String? fullName,
    String? message,
    File? image,
    String? imageName,
    String? imageUrl,
    DocumentReference? id,
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
      image: image ?? this.image,
      imageUrl: imageUrl ?? this.imageUrl,
      id: id ?? this.id,
      imageName: imageName ?? this.imageName,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        passwordConf,
        username,
        fullName,
        message,
        formStatus,
        image,
        imageUrl,
        id,
        imageName,
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
          imageName: "",
          imageUrl: "",
          id: null,
          image: null,
          formStatus: FormStatusEnum.initForm,
        );
}
