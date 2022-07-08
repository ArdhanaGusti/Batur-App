import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecase/remove_news.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsRemoveBloc extends Bloc<NewsEvent, NewsState> {
  final RemoveNews removeNews;

  NewsRemoveBloc(this.removeNews) : super(NewsEmpty()) {
    on<OnRemoveNews>(
      (event, emit) async {
        emit(NewsLoading());
        final result = await removeNews.execute(
            event.context, event.index, event.coverUrl);

        result.fold(
          (failure) {
            emit(NewsError(failure.message));
          },
          (data) {
            emit(NewsRemoved(data));
          },
        );
      },
    );
  }
}
