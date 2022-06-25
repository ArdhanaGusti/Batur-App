import '../../domain/usecase/remove_news.dart';
import '../../presentation/bloc/news_event.dart';
import '../../presentation/bloc/news_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsRemoveBloc extends Bloc<NewsEvent, NewsState> {
  final RemoveNews removeNews;

  NewsRemoveBloc(this.removeNews) : super(NewsEmpty()) {
    on<OnRemoveNews>(
      (event, emit) async {
        emit(NewsLoading());
        final result = await removeNews.execute(event.index, event.coverUrl);

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
