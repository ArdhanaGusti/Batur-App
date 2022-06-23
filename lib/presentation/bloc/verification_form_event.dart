part of 'verification_form_bloc.dart';

abstract class VerificationFormEvent extends Equatable {
  const VerificationFormEvent();

  @override
  List<Object> get props => [];
}

class VerificationInputNumber extends VerificationFormEvent {
  final String number;
  final int numberField;
  const VerificationInputNumber({
    required this.number,
    required this.numberField,
  });

  @override
  List<Object> get props => [number, numberField];
}

class VerificationSubmiting extends VerificationFormEvent {
  final bool isRegis;
  const VerificationSubmiting({required this.isRegis});

  @override
  List<Object> get props => [isRegis];
}
