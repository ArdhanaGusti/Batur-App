import 'package:capstone_design/domain/usecase/login_email.dart';
import 'package:capstone_design/domain/usecase/sign_in_email.dart';
import 'package:capstone_design/presentation/bloc/login/login_event.dart';
import 'package:capstone_design/presentation/bloc/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInEmailBloc extends Bloc<LoginEvent, LoginState> {
  final SignInEmail signInEmail;

  SignInEmailBloc(this.signInEmail) : super(LoginEmpty()) {
    on<OnSignInEmail>(
      (event, emit) async {
        emit(LoginLoading());
        final result =
            await signInEmail.execute(event.context, event.email, event.pass);

        result.fold(
          (failure) {
            emit(LoginError(failure.message));
          },
          (data) {
            emit(SignInEmailSuccess(data));
          },
        );
      },
    );
  }
}
