import 'dart:io';

import 'package:account/domain/usecase/edit_profile.dart';
import 'package:account/utils/enum/form_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final EditProfile editProfile;
  ProfileBloc(this.editProfile) : super(const ProfileInitial()) {
    on<ProfileFormEmailChanged>((event, emit) {
      final newEmail = event.email;

      emit(state.copyWith(
        email: newEmail,
      ));
    });

    on<ProfileFormPasswordChanged>((event, emit) {
      final newPassword = event.password;

      emit(state.copyWith(
        password: newPassword,
      ));
    });

    on<ProfileFormPasswordConfChanged>((event, emit) {
      final newPasswordConf = event.passwordConf;

      emit(state.copyWith(
        passwordConf: newPasswordConf,
      ));
    });

    on<ProfileFormUsernameChanged>((event, emit) {
      final newUsername = event.username;

      emit(state.copyWith(
        username: newUsername,
      ));
    });

    on<ProfileFormFullNameChanged>((event, emit) {
      final newFullName = event.fullName;

      emit(state.copyWith(
        fullName: newFullName,
      ));
    });

    on<OnInit>((event, emit) {
      final newFullName = event.fullName;
      final newUserName = event.username;
      final newEmail = event.email;
      final newUrl = event.imageUrl;
      final newid = event.id;

      emit(state.copyWith(
        fullName: newFullName,
        username: newUserName,
        email: newEmail,
        imageUrl: newUrl,
        id: newid,
      ));
    });

    on<OnAddImage>((event, emit) {
      final imageNew = event.image;
      final imageNameNew = event.imageName;

      emit(state.copyWith(
        image: imageNew,
        imageName: imageNameNew,
        message: "Berhasil Mengganti Photo Profile",
      ));
    });

    on<OnSubmitEdit>((event, emit) async {
      emit(state.copyWith(
        formStatus: FormStatusEnum.submittingForm,
      ));

      if (state.id == null) {
        emit(state.copyWith(
          formStatus: FormStatusEnum.failedSubmission,
          message: "User ID is Not Define",
        ));
      } else {
        final result = await editProfile.execute(
          state.username,
          state.fullName,
          state.imageName,
          state.imageUrl,
          state.image,
          state.id!,
        );

        result.fold(
          (failure) {
            emit(state.copyWith(
              formStatus: FormStatusEnum.failedSubmission,
              message: failure.message,
            ));
          },
          (data) {
            emit(state.copyWith(
              formStatus: FormStatusEnum.successSubmission,
              message: data,
            ));
          },
        );
      }
    });
  }
}
