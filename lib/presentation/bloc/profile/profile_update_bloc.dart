import 'package:capstone_design/domain/usecase/create_profile.dart';
import 'package:capstone_design/domain/usecase/update_profile.dart';
import 'package:capstone_design/presentation/bloc/profile/profile_event.dart';
import 'package:capstone_design/presentation/bloc/profile/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileUpdateBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdateProfile updateProfile;

  ProfileUpdateBloc(this.updateProfile) : super(ProfileEmpty()) {
    on<OnUpdateProfile>(
      (event, emit) async {
        emit(ProfileLoading());
        final result = await updateProfile.execute(
            event.context,
            event.username,
            event.fullname,
            event.imageName,
            event.urlName,
            event.image,
            event.index);

        result.fold(
          (failure) {
            emit(ProfileError(failure.message));
          },
          (data) {
            emit(ProfileCreated(data));
          },
        );
      },
    );
  }
}
