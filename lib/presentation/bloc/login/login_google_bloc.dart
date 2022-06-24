import 'package:capstone_design/domain/usecase/login_google.dart';
import 'package:capstone_design/presentation/bloc/login/login_event.dart';
import 'package:capstone_design/presentation/bloc/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginGoogleBloc extends Bloc<LoginEvent, LoginState> {
  final LoginGoogle loginGoogle;

  LoginGoogleBloc(this.loginGoogle) : super(LoginEmpty()) {
    on<OnLoginGoogle>(
      (event, emit) async {
        emit(LoginLoading());
        final result = await loginGoogle.execute(event.context);

        result.fold(
          (failure) {
            emit(LoginError(failure.message));
          },
          (data) {
            emit(LoginGoogleSuccess(data));
          },
        );
      },
    );
  }
}
