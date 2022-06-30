part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileFormEmailChanged extends ProfileEvent {
  final String email;
  const ProfileFormEmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class ProfileFormPasswordChanged extends ProfileEvent {
  final String password;
  const ProfileFormPasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

class ProfileFormPasswordConfChanged extends ProfileEvent {
  final String passwordConf;
  const ProfileFormPasswordConfChanged({required this.passwordConf});

  @override
  List<Object> get props => [passwordConf];
}

class ProfileFormUsernameChanged extends ProfileEvent {
  final String username;
  const ProfileFormUsernameChanged({required this.username});

  @override
  List<Object> get props => [username];
}

class OnInit extends ProfileEvent {
  final String fullName;
  final String email;
  final String username;
  final String imageUrl;
  final DocumentReference id;
  const OnInit({
    required this.fullName,
    required this.username,
    required this.email,
    required this.imageUrl,
    required this.id,
  });

  @override
  List<Object> get props => [fullName, username, email, imageUrl, id];
}

class ProfileFormFullNameChanged extends ProfileEvent {
  final String fullName;
  const ProfileFormFullNameChanged({required this.fullName});

  @override
  List<Object> get props => [fullName];
}

class OnAddImage extends ProfileEvent {
  final File? image;
  final String? imageName;
  const OnAddImage(this.image, this.imageName);

  @override
  List<Object?> get props => [image, imageName];
}

class OnSubmitEdit extends ProfileEvent {
  const OnSubmitEdit();

  @override
  List<Object?> get props => [];
}
