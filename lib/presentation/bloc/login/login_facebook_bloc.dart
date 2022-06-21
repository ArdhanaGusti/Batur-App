import 'package:capstone_design/domain/usecase/login_facebook.dart';
import 'package:capstone_design/presentation/bloc/login/login_event.dart';
import 'package:capstone_design/presentation/bloc/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginFacebookBloc extends Bloc<LoginEvent, LoginState> {
  final LoginFacebook loginFacebook;

  LoginFacebookBloc(this.loginFacebook) : super(LoginEmpty()) {
    on<OnLoginFacebook>(
      (event, emit) async {
        emit(LoginLoading());
        final result = await loginFacebook.execute(event.context);

        result.fold(
          (failure) {
            emit(LoginError(failure.message));
          },
          (data) {
            emit(LoginFacebookSuccess(data));
          },
        );
      },
    );
  }
}
