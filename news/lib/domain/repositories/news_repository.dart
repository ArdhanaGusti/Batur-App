import 'package:dartz/dartz.dart';
import 'package:news/data/model/news.dart';
import 'package:news/utils/failure.dart';

abstract class NewsRepository {
  Future<Either<Failure, ArticlesResult>> getNews();
}