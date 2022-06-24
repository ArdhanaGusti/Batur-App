part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class SaveNotificationMode extends NotificationEvent {
  final NotificationEnum notif;
  const SaveNotificationMode({required this.notif});

  @override
  List<Object> get props => [notif];
}

class LoadNotification extends NotificationEvent {
  const LoadNotification();

  @override
  List<Object> get props => [];
}
