import 'package:bloc/bloc.dart';
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
  }
}
