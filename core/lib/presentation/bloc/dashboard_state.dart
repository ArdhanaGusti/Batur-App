part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  final int indexBottomNav;

  const DashboardState({
    required this.indexBottomNav,
  });

  DashboardState copyWith({
    int? indexBottomNav,
  }) {
    return DashboardState(
      indexBottomNav: indexBottomNav ?? this.indexBottomNav,
    );
  }

  @override
  List<Object> get props => [
        indexBottomNav,
      ];
}

class DashboardInitial extends DashboardState {
  const DashboardInitial()
      : super(
          indexBottomNav: 0,
        );
}
