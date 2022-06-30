part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class IndexBottomNavChange extends DashboardEvent {
  final int newIndex;
  const IndexBottomNavChange({required this.newIndex});

  @override
  List<Object> get props => [newIndex];
}

class IsLogInChange extends DashboardEvent {
  const IsLogInChange();

  @override
  List<Object> get props => [];
}

class IsLogInSave extends DashboardEvent {
  final bool value;
  const IsLogInSave({required this.value});

  @override
  List<Object> get props => [value];
}

class IsAdminSave extends DashboardEvent {
  final bool value;
  const IsAdminSave({required this.value});

  @override
  List<Object> get props => [value];
}

class OnSaveRemembermeDashboard extends DashboardEvent {
  const OnSaveRemembermeDashboard();
  @override
  List<Object> get props => [];
}

class SingOut extends DashboardEvent {
  const SingOut();

  @override
  List<Object> get props => [];
}

class OnIsAdmin extends DashboardEvent {
  final String email;
  const OnIsAdmin({required this.email});
  @override
  List<Object> get props => [email];
}

class OnIsHaveProfile extends DashboardEvent {
  final String email;
  const OnIsHaveProfile({required this.email});
  @override
  List<Object> get props => [email];
}

class OnIsHaveProfileSave extends DashboardEvent {
  final bool value;
  const OnIsHaveProfileSave({required this.value});

  @override
  List<Object> get props => [value];
}
