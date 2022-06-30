part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  final int indexBottomNav;
  final bool isLogIn;
  final bool isAdmin;
  final bool isHaveProfile;

  const DashboardState({
    required this.indexBottomNav,
    required this.isLogIn,
    required this.isAdmin,
    required this.isHaveProfile,
  });

  DashboardState copyWith({
    int? indexBottomNav,
    bool? isLogIn,
    bool? isAdmin,
    bool? isHaveProfile,
  }) {
    return DashboardState(
      indexBottomNav: indexBottomNav ?? this.indexBottomNav,
      isLogIn: isLogIn ?? this.isLogIn,
      isAdmin: isAdmin ?? this.isAdmin,
      isHaveProfile: isHaveProfile ?? this.isHaveProfile,
    );
  }

  @override
  List<Object> get props => [
        indexBottomNav,
        isLogIn,
        isAdmin,
        isHaveProfile,
      ];
}

class DashboardInitial extends DashboardState {
  const DashboardInitial()
      : super(
          indexBottomNav: 0,
          isLogIn: false,
          isAdmin: false,
          isHaveProfile: false,
        );
}
