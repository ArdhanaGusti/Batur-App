import 'package:bloc/bloc.dart';
import 'package:capstone_design/utils/enum/form_enum.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileInitial()) {
    on<ProfileFormEmailChanged>((event, emit) {
      final newEmail = event.email;

      emit(state.copyWith(
        email: newEmail,
      ));
    });

    on<ProfileFormPasswordChanged>((event, emit) {
      final newPassword = event.password;

      emit(state.copyWith(
        password: newPassword,
      ));
    });

    on<ProfileFormPasswordConfChanged>((event, emit) {
      final newPasswordConf = event.passwordConf;

      emit(state.copyWith(
        passwordConf: newPasswordConf,
      ));
    });

    on<ProfileFormUsernameChanged>((event, emit) {
      final newUsername = event.username;

      emit(state.copyWith(
        username: newUsername,
      ));
    });

    on<ProfileFormFullNameChanged>((event, emit) {
      final newFullName = event.fullName;

      emit(state.copyWith(
        fullName: newFullName,
      ));
    });
  }
}
