import 'package:bloc/bloc.dart';
import 'package:capstone_design/utils/enum/form_enum.dart';
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
  }
}
