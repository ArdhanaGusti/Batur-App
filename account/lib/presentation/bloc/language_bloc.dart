import 'package:account/utils/enum/language_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageInitial()) {
    on<SaveLanguageMode>((event, emit) async {
      final languageNewValue = event.language;

      emit(state.copyWith(
        language: languageNewValue,
      ));
    });
  }
}
