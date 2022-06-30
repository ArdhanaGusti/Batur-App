import 'package:account/account.dart';
import 'package:core/domain/usecase/set_remember_me.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetIsLogIn getIsLogIn;
  final SaveIsLogIn saveIsLogIn;
  final EmailSignOut emailSignOut;
  final GoogleSignOut googleSignOut;
  final FacebookSignOut facebookSignOut;
  final IsAdmin isAdmin;
  final IsHaveProfile isHaveProfile;
  final SetRememberMe setRememberMe;

  DashboardBloc(
    this.getIsLogIn,
    this.saveIsLogIn,
    this.emailSignOut,
    this.googleSignOut,
    this.facebookSignOut,
    this.isAdmin,
    this.isHaveProfile,
    this.setRememberMe,
  ) : super(const DashboardInitial()) {
    on<IndexBottomNavChange>((event, emit) async {
      final newValueBottomNav = event.newIndex;

      emit(state.copyWith(
        indexBottomNav: newValueBottomNav,
      ));
    });

    on<OnIsHaveProfile>((event, emit) async {
      final newValue = await isHaveProfile.execute(event.email);

      emit(state.copyWith(
        isHaveProfile: newValue,
      ));
    });

    on<OnIsHaveProfileSave>((event, emit) async {
      emit(state.copyWith(
        isHaveProfile: event.value,
      ));
    });

    on<OnIsAdmin>((event, emit) async {
      final newValue = await isAdmin.execute(event.email);

      emit(state.copyWith(
        isAdmin: newValue,
      ));
    });

    on<IsAdminSave>((event, emit) async {
      final newValue = event.value;

      emit(state.copyWith(
        isAdmin: newValue,
      ));
    });

    on<IsLogInChange>((event, emit) async {
      final newValueLogIn = await getIsLogIn.execute();

      emit(state.copyWith(
        isLogIn: newValueLogIn,
      ));
    });

    on<IsLogInSave>((event, emit) async {
      final value = event.value;
      final newValueLogIn = await saveIsLogIn.execute(value);

      if (newValueLogIn) {
        emit(state.copyWith(
          isLogIn: value,
        ));
      } else {
        print("error");
      }
    });

    on<OnSaveRemembermeDashboard>((event, emit) async {
      final result = await setRememberMe.execute(false);
    });

    on<SingOut>((event, emit) async {
      final email = await emailSignOut.execute();
      final google = await googleSignOut.execute();
      final facebook = await facebookSignOut.execute();

      if (email.isRight() || google.isRight() || facebook.isRight()) {
        emit(state.copyWith(
          isLogIn: false,
        ));
      }
    });
  }
}
