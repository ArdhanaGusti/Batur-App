import 'package:capstone_design/domain/usecase/create_profile.dart';
import 'package:capstone_design/presentation/bloc/profile/profile_event.dart';
import 'package:capstone_design/presentation/bloc/profile/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCreateBloc extends Bloc<ProfileEvent, ProfileState> {
  final CreateProfile createProfile;

  ProfileCreateBloc(this.createProfile) : super(ProfileEmpty()) {
    on<OnCreateProfile>(
      (event, emit) async {
        emit(ProfileLoading());
        final result = await createProfile.execute(
            event.context,
            event.username,
            event.fullname,
            event.imageName,
            event.email,
            event.image,
            event.user);

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
