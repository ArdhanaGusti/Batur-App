part of 'news_list_bloc.dart';

abstract class NewsListEvent extends Equatable {
  const NewsListEvent();

  @override
  List<Object?> get props => [];
}

class NewsListGetEvent extends NewsListEvent {}