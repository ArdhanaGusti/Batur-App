import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news/data/model/news.dart';

import '../../../domain/usecase/get_news.dart';

part 'news_list_event.dart';

part 'news_list_state.dart';

class NewsListBloc extends Bloc<NewsListEvent, NewsListState> {
  final GetNews _getNews;

  NewsListBloc(this._getNews) : super(NewsListEmpty()) {
    on<NewsListEvent>((event, emit) async {
      emit(NewsListLoading());
      final result = await _getNews.execute();

      result.fold(
            (failure) {
          emit(NewsListError(failure.message));
        },
            (data) {
          emit(NewsListLoaded(data));
        },
      );
    });
  }
}
