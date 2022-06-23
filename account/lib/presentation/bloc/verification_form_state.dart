part of 'verification_form_bloc.dart';

class VerificationFormState extends Equatable {
  final int verification;
  final bool isRegis;
  final String number1;
  final String number2;
  final String number3;
  final String number4;
  final FormStatusEnum formStatus;

  const VerificationFormState({
    required this.verification,
    required this.isRegis,
    required this.number1,
    required this.number2,
    required this.number3,
    required this.number4,
    required this.formStatus,
  });

  VerificationFormState copyWith({
    int? verification,
    bool? isRegis,
    String? number1,
    String? number2,
    String? number3,
    String? number4,
    FormStatusEnum? formStatus,
  }) {
    return VerificationFormState(
      verification: verification ?? this.verification,
      isRegis: isRegis ?? this.isRegis,
      number1: number1 ?? this.number1,
      number2: number2 ?? this.number2,
      number3: number3 ?? this.number3,
      number4: number4 ?? this.number4,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  List<Object> get props => [
        verification,
        isRegis,
        number1,
        number2,
        number3,
        number4,
        formStatus,
      ];
}

class VerificationFormInitial extends VerificationFormState {
  static bool isRegisInit = false;

  VerificationFormInitial()
      : super(
          verification: 0,
          isRegis: isRegisInit,
          number1: '',
          number2: '',
          number3: '',
          number4: '',
          formStatus: FormStatusEnum.initForm,
        );
}
