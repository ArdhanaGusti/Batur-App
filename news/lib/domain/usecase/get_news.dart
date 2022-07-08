import 'package:dartz/dartz.dart';
import 'package:news/data/model/news.dart';
import '../../utils/failure.dart';
import '../repositories/news_repository.dart';

class GetNews {
  final NewsRepository repository;

  GetNews(this.repository);

  Future<Either<Failure, ArticlesResult>> execute() {
    return repository.getNews();
  }
}