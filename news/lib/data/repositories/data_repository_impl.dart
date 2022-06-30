import 'dart:io';
import '../../data/datasources/crud_news.dart';
import '../../domain/repositories/data_repository.dart';
import '../../utils/exception.dart';
import '../../utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataRepositoryImplNews implements DataRepositoryNews {
  final CrudNews crudNews;

  DataRepositoryImplNews({
    required this.crudNews,
  });

  @override
  Future<Either<Failure, String>> editNews(
      BuildContext context,
      File? imageNow,
      String? imageNameNow,
      String judulNow,
      kontenNow,
      urlNameNow,
      DocumentReference<Object?> index) async {
    try {
      final res = await crudNews.editNews(context, imageNow, imageNameNow,
          judulNow, kontenNow, urlNameNow, index);
      return Right(res);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> sendNews(
      BuildContext context, File image, String imageName, judul, konten) async {
    try {
      final res =
          await crudNews.sendNews(context, image, imageName, judul, konten);
      return Right(res);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> removeNews(BuildContext context,
      DocumentReference<Object?> index, String coverUrl) async {
    try {
      final res = await crudNews.removeNews(context, index, coverUrl);
      return Right(res);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
