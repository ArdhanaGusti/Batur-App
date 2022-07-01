import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:news/data/datasources/news_remote_data_source.dart';
import 'package:news/data/model/news.dart';
import 'package:news/domain/repositories/news_repository.dart';
import 'package:news/utils/failure.dart';

import '../../utils/exception.dart';

class NewsRepositoryImpl implements NewsRepository {
  late final NewsRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, ArticlesResult>> getNews() async {
    // TODO: implement getNews
    try {
      final result = await remoteDataSource.bandungNewsId();
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certified not valid:\n${e.message}'));
    }
    throw UnimplementedError();
  }
}