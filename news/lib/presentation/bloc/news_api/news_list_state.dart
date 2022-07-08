part of 'news_list_bloc.dart';

abstract class NewsListState extends Equatable {
  const NewsListState();
  
  @override
  List<Object?> get props => [];
}

class NewsListEmpty extends NewsListState {}

class NewsListLoading extends NewsListState {}

class NewsListError extends NewsListState {
  final String message;

  const NewsListError(this.message);

  @override
  List<Object> get props => [message];
}

class NewsListLoaded extends NewsListState {
  final ArticlesResult result;

  const NewsListLoaded(this.result);

  @override
  List<Object> get props => [result];
}