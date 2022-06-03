import 'package:bloc/bloc.dart';
import 'package:capstone_design/utils/enum/form_enum.dart';
import 'package:equatable/equatable.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  LoginFormBloc() : super(LoginFormInitial()) {
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
  }
}
