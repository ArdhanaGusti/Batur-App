import 'package:account/utils/enum/form_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordFormBloc
    extends Bloc<ForgotPasswordFormEvent, ForgotPasswordFormState> {
  ForgotPasswordFormBloc() : super(const ForgotPasswordInitial()) {
    on<ForgotPasswordFormEmailChanged>((event, emit) {
      final newEmail = event.email;

      emit(state.copyWith(
        email: newEmail,
      ));
    });

    on<ForgotPasswordFormPasswordChanged>((event, emit) {
      final newPassword = event.password;

      emit(state.copyWith(
        password: newPassword,
      ));
    });

    on<ForgotPasswordFormPasswordConfChanged>((event, emit) {
      final newPassConf = event.passwordConf;

      emit(state.copyWith(
        passwordConf: newPassConf,
      ));
    });

    on<ForgotPasswordFormObsecurePasswordChanged>((event, emit) {
      final newObsecure = event.obsecure;

      emit(state.copyWith(
        obsecurePassword: newObsecure,
      ));
    });

    on<ForgotPasswordFormObsecurePasswordConfChanged>((event, emit) {
      final newObsecureConf = event.obsecureConf;

      emit(state.copyWith(
        obsecurePasswordConf: newObsecureConf,
      ));
    });
  }
}
