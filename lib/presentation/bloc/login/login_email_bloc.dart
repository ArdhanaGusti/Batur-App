import 'package:capstone_design/domain/usecase/login_email.dart';
import 'package:capstone_design/presentation/bloc/login/login_event.dart';
import 'package:capstone_design/presentation/bloc/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginEmailBloc extends Bloc<LoginEvent, LoginState> {
  final LoginEmail loginEmail;

  LoginEmailBloc(this.loginEmail) : super(LoginEmpty()) {
    on<OnLoginEmail>(
      (event, emit) async {
        emit(LoginLoading());
        final result =
            await loginEmail.execute(event.context, event.email, event.pass);

        result.fold(
          (failure) {
            emit(LoginError(failure.message));
          },
          (data) {
            emit(LoginEmailSuccess(data));
          },
        );
      },
    );
  }
}
