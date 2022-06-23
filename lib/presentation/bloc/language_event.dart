part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class SaveLanguageMode extends LanguageEvent {
  final LanguageEnum language;
  const SaveLanguageMode({required this.language});

  @override
  List<Object> get props => [language];
}

class LoadLanguage extends LanguageEvent {
  const LoadLanguage();

  @override
  List<Object> get props => [];
}
