import 'package:capstone_design/domain/usecase/create_news.dart';
import 'package:capstone_design/presentation/bloc/news/news_event.dart';
import 'package:capstone_design/presentation/bloc/news/news_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCreateBloc extends Bloc<NewsEvent, NewsState> {
  final CreateNews createNews;

  NewsCreateBloc(this.createNews) : super(NewsEmpty()) {
    on<OnCreateNews>(
      (event, emit) async {
        emit(NewsLoading());
        final result = await createNews.execute(event.context, event.image,
            event.imageName, event.judul, event.konten);

        result.fold(
          (failure) {
            emit(NewsError(failure.message));
          },
          (data) {
            emit(NewsCreated(data));
          },
        );
      },
    );
  }
}
