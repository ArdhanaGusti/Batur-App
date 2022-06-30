import 'dart:io';
import 'package:account/domain/usecase/delete_auth.dart';
import 'package:account/domain/usecase/email_sign_up.dart';
import 'package:account/domain/usecase/facebook_sign_up.dart';
import 'package:account/domain/usecase/google_sign_up.dart';
import 'package:account/domain/usecase/is_have_profile.dart';
import 'package:account/domain/usecase/register_profile.dart';
import 'package:account/utils/enum/form_enum.dart';
import 'package:core/domain/usecase/set_remember_me.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'regis_form_event.dart';
part 'regis_form_state.dart';

class RegisFormBloc extends Bloc<RegisFormEvent, RegisFormState> {
  final EmailSignUp emailSignUp;
  final GoogleSignUp googleSignUp;
  final FacebookSignUp facebookSignUp;
  final RegisterProfile registerProfile;
  final IsHaveProfile isHaveProfile;
  final SetRememberMe setRememberMe;
  final DeleteAuth deleteAuth;

  RegisFormBloc(
    this.emailSignUp,
    this.googleSignUp,
    this.facebookSignUp,
    this.registerProfile,
    this.isHaveProfile,
    this.setRememberMe,
    this.deleteAuth,
  ) : super(RegisFormInitial()) {
    on<RegisFormEmailChanged>((event, emit) {
      final newEmail = event.email;

      emit(state.copyWith(
        email: newEmail,
      ));
    });

    on<RegisFormPasswordChanged>((event, emit) {
      final newPassword = event.password;

      emit(state.copyWith(
        password: newPassword,
      ));
    });

    on<RegisFormObsecurePasswordChanged>((event, emit) {
      final newObsecure = event.obsecure;

      emit(state.copyWith(
        obsecurePassword: newObsecure,
      ));
    });

    on<RegisFormPasswordConfChanged>((event, emit) {
      final newPassword = event.passwordConf;

      emit(state.copyWith(
        passwordConf: newPassword,
      ));
    });

    on<RegisFormObsecurePasswordConfChanged>((event, emit) {
      final newObsecure = event.obsecureConf;

      emit(state.copyWith(
        obsecurePasswordConf: newObsecure,
      ));
    });

    on<RegisFormUsernameChanged>((event, emit) {
      final newUsername = event.username;

      emit(state.copyWith(
        username: newUsername,
      ));
    });

    on<RegisFormFullNameChanged>((event, emit) {
      final newFullName = event.fullName;

      emit(state.copyWith(
        fullName: newFullName,
      ));
    });

    on<RegisFormRememberMeChanged>((event, emit) {
      final newRememberMe = event.rememberMe;

      emit(state.copyWith(
        rememberMe: newRememberMe,
      ));
    });

    on<OnEmailSignUp>((event, emit) async {
      emit(state.copyWith(
        formStatus: FormStatusEnum.submittingForm,
        isEmail: true,
      ));

      final check = await isHaveProfile.execute(state.email);

      if (check) {
        emit(state.copyWith(
          formStatus: FormStatusEnum.failedSubmission,
          // Text wait localization
          message: "Failed Sign Up Because Profile Have be Created",
        ));
      } else {
        final result = await emailSignUp.execute(state.email, state.password);

        await setRememberMe.execute(state.rememberMe);

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

    on<OnGoogleSignUp>((event, emit) async {
      emit(state.copyWith(
        formStatus: FormStatusEnum.submittingForm,
        isGoogle: true,
      ));

      final result = await googleSignUp.execute();

      await setRememberMe.execute(state.rememberMe);

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
    });

    on<OnFacebookSignUp>((event, emit) async {
      emit(state.copyWith(
        formStatus: FormStatusEnum.submittingForm,
        isFacebook: true,
      ));

      final result = await facebookSignUp.execute();

      await setRememberMe.execute(state.rememberMe);

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
    });

    on<OnSignUp>((event, emit) async {
      emit(state.copyWith(
        formStatus: FormStatusEnum.submittingForm,
      ));

      final check = await isHaveProfile.execute(state.email);

      if (!check) {
        final result = await registerProfile.execute(
          state.username,
          state.fullName,
          event.imageName,
          state.email,
          event.image,
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
      } else {
        emit(state.copyWith(
          formStatus: FormStatusEnum.failedSubmission,
          // Text wait localization
          message: "Failed Sign Up, Did'n Have A Profile",
        ));
      }
    });
  }
}
