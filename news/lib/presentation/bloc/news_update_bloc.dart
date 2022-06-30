import '../../domain/usecase/update_news.dart';
import '../../presentation/bloc/news_event.dart';
import '../../presentation/bloc/news_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsUpdateBloc extends Bloc<NewsEvent, NewsState> {
  final UpdateNews updateNews;

  NewsUpdateBloc(this.updateNews) : super(NewsEmpty()) {
    on<OnUpdateNews>(
      (event, emit) async {
        emit(NewsLoading());
        final result = await updateNews.execute(
          event.context,
          event.image,
          event.imageName,
          event.judul,
          event.konten,
          event.urlName,
          event.index,
        );

        result.fold(
          (failure) {
            emit(NewsError(failure.message));
          },
          (data) {
            emit(NewsUpdated(data));
          },
        );
      },
    );
  }
}
