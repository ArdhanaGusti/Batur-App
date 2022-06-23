part of 'language_bloc.dart';

class LanguageState extends Equatable {
  final LanguageEnum language;
  final String message;

  const LanguageState({
    required this.language,
    required this.message,
  });

  LanguageState copyWith({
    LanguageEnum? language,
    String? message,
  }) {
    return LanguageState(
      language: language ?? this.language,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        language,
        message,
      ];
}

class LanguageInitial extends LanguageState {
  const LanguageInitial()
      : super(
          language: LanguageEnum.indonesia,
          message: '',
        );
}
