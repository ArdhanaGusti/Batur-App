import 'package:account/utils/enum/form_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'regis_form_event.dart';
part 'regis_form_state.dart';

class RegisFormBloc extends Bloc<RegisFormEvent, RegisFormState> {
  RegisFormBloc() : super(RegisFormInitial()) {
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
  }
}
