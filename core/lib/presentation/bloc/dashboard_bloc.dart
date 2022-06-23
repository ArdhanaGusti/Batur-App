import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardInitial()) {
    on<IndexBottomNavChange>((event, emit) async {
      final newValueBottomNav = event.newIndex;

      emit(state.copyWith(
        indexBottomNav: newValueBottomNav,
      ));
    });
  }
}
