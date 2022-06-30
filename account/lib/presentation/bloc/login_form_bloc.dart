import 'package:account/domain/usecase/email_sign_in.dart';
import 'package:account/domain/usecase/facebook_sign_in.dart';
import 'package:account/domain/usecase/google_sign_in.dart';
import 'package:account/domain/usecase/is_have_profile.dart';
import 'package:account/utils/enum/form_enum.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  final EmailSignIn emailSignIn;
  final GoogleSignIn googleSignIn;
  final FacebookSignIn facebookSignIn;
  final IsHaveProfile isHaveProfile;
  final SetRememberMe setRememberMe;

  LoginFormBloc(
    this.emailSignIn,
    this.googleSignIn,
    this.facebookSignIn,
    this.isHaveProfile,
    this.setRememberMe,
  ) : super(LoginFormInitial()) {
    on<LoginFormEmailChanged>((event, emit) {
      final newEmail = event.email;

      emit(state.copyWith(
        email: newEmail,
      ));
    });

    on<LoginFormPasswordChanged>((event, emit) {
      final newPassword = event.password;

      emit(state.copyWith(
        password: newPassword,
      ));
    });

    on<LoginFormObsecurePasswordChanged>((event, emit) {
      final newObsecure = event.obsecure;

      emit(state.copyWith(
        obsecurePassword: newObsecure,
      ));
    });

    on<LoginFormRememberMeChanged>((event, emit) {
      final newRememberMe = event.rememberMe;

      emit(state.copyWith(
        rememberMe: newRememberMe,
      ));
    });

    on<OnSaveRememberme>((event, emit) async {
      final result = await setRememberMe.execute(state.rememberMe);

      if (result) {
        emit(state.copyWith(
          rememberMe: state.rememberMe,
        ));
      }
    });

    on<OnEmailSignIn>((event, emit) async {
      emit(state.copyWith(
        formStatus: FormStatusEnum.submittingForm,
      ));

      final result = await emailSignIn.execute(
        state.email,
        state.password,
      );

      add(const OnSaveRememberme());

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

    on<OnGoogleSignIn>((event, emit) async {
      emit(state.copyWith(
        formStatus: FormStatusEnum.submittingForm,
      ));

      final result = await googleSignIn.execute();

      result.fold(
        (failure) {
          emit(state.copyWith(
            formStatus: FormStatusEnum.failedSubmission,
            message: failure.message,
          ));
        },
        (data) {
          add(const OnSaveRememberme());

          emit(state.copyWith(
            formStatus: FormStatusEnum.successSubmission,
            message: data,
          ));
        },
      );
    });

    on<OnFacebookSignIn>((event, emit) async {
      emit(state.copyWith(
        formStatus: FormStatusEnum.submittingForm,
      ));

      final result = await facebookSignIn.execute();

      result.fold(
        (failure) {
          emit(state.copyWith(
            formStatus: FormStatusEnum.failedSubmission,
            message: failure.message,
          ));
        },
        (data) {
          add(const OnSaveRememberme());

          emit(state.copyWith(
            formStatus: FormStatusEnum.successSubmission,
            message: data,
          ));
        },
      );
    });
  }
}
