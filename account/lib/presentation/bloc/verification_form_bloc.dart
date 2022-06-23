import 'package:account/utils/enum/form_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verification_form_event.dart';
part 'verification_form_state.dart';

class VerificationFormBloc
    extends Bloc<VerificationFormEvent, VerificationFormState> {
  VerificationFormBloc() : super(VerificationFormInitial()) {
    on<VerificationInputNumber>((event, emit) {
      final newNumber = event.number;
      final field = event.numberField;

      if (field == 1) {
        emit(state.copyWith(
          number1: newNumber,
        ));
      } else if (field == 2) {
        emit(state.copyWith(
          number2: newNumber,
        ));
      } else if (field == 3) {
        emit(state.copyWith(
          number3: newNumber,
        ));
      } else {
        emit(state.copyWith(
          number4: newNumber,
        ));
      }
    });

    on<VerificationSubmiting>((event, emit) {
      final isRegis = event.isRegis;

      final stringCode =
          state.number1 + state.number2 + state.number3 + state.number4;
      final verifCode = int.parse(stringCode);

      if (isRegis) {
        emit(state.copyWith(
          isRegis: isRegis,
          verification: verifCode,
          formStatus: FormStatusEnum.submittingForm,
        ));
      } else {
        emit(state.copyWith(
          isRegis: isRegis,
          verification: verifCode,
          formStatus: FormStatusEnum.submittingForm,
        ));
      }
    });
  }
}
