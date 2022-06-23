part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  final NotificationEnum notif;
  final String message;

  const NotificationState({
    required this.notif,
    required this.message,
  });

  NotificationState copyWith({
    NotificationEnum? notif,
    String? message,
  }) {
    return NotificationState(
      notif: notif ?? this.notif,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        notif,
        message,
      ];
}

class NotificationInitial extends NotificationState {
  const NotificationInitial()
      : super(
          notif: NotificationEnum.off,
          message: '',
        );
}
