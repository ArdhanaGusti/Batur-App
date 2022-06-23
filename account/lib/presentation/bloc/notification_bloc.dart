import 'package:account/utils/enum/notification_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(const NotificationInitial()) {
    on<SaveNotificationMode>((event, emit) async {
      final notificationNewValue = event.notif;

      emit(state.copyWith(
        notif: notificationNewValue,
      ));
    });
  }
}
