import 'dart:io';
import 'package:capstone_design/data/datasources/crud_news.dart';
import 'package:capstone_design/data/datasources/crud_profile.dart';
import 'package:capstone_design/data/datasources/crud_tour.dart';
import 'package:capstone_design/data/datasources/crud_train.dart';
import 'package:capstone_design/data/datasources/crud_umkm.dart';
import 'package:capstone_design/domain/repository/data_repository.dart';
import 'package:capstone_design/utils/exception.dart';
import 'package:capstone_design/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataRepositoryImpl implements DataRepository {
  final CrudUmkm crudUmkm;
  final CrudNews crudNews;
  final CrudProfile crudProfile;
  final CrudTour crudTour;
  final CrudTrain crudTrain;

  DataRepositoryImpl({
    required this.crudUmkm,
    required this.crudNews,
    required this.crudProfile,
    required this.crudTour,
    required this.crudTrain,
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
  Future<Either<Failure, String>> editProfile(
      BuildContext context,
      String usernameNow,
      fullnameNow,
      imageName,
      urlNameNow,
      File? image,
      DocumentReference<Object?> index) async {
    try {
      final res = await crudProfile.editProfile(context, usernameNow,
          fullnameNow, imageName, urlNameNow, image, index);
      return Right(res);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> editUmkm(
      BuildContext context,
      File? image,
      String coverUrlNow,
      String? imageName,
      String nameNow,
      String typeNow,
      String descNow,
      double latitude,
      double longitude,
      DocumentReference<Object?> index) async {
    try {
      final res = await crudUmkm.editUmkm(context, image, coverUrlNow,
          imageName, nameNow, typeNow, descNow, latitude, longitude, index);
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
  Future<Either<Failure, String>> sendProfile(
      BuildContext context,
      String username,
      fullname,
      imageName,
      email,
      File image,
      User user) async {
    try {
      final res = await crudProfile.sendProfile(
          context, username, fullname, imageName, email, image, user);
      return Right(res);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> sendUmkm(
    BuildContext context,
    String imageName,
    String name,
    String type,
    String desc,
    File image,
    double latitude,
    double longitude,
  ) async {
    try {
      final res = await crudUmkm.sendUmkm(
        context,
        imageName,
        name,
        type,
        desc,
        image,
        latitude,
        longitude,
      );
      return Right(res);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> sendTour(
    BuildContext context,
    String imageName,
    String name,
    String type,
    String desc,
    File image,
    double latitude,
    double longitude,
  ) async {
    try {
      final res = await crudTour.sendTour(
        context,
        imageName,
        name,
        type,
        desc,
        image,
        latitude,
        longitude,
      );
      return Right(res);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> editTour(
    BuildContext context,
    File? image,
    String coverUrlNow,
    String? imageName,
    String nameNow,
    String typeNow,
    String descNow,
    double latitude,
    double longitude,
    DocumentReference index,
  ) async {
    try {
      final res = await crudTour.editTour(context, image, coverUrlNow,
          imageName, nameNow, typeNow, descNow, latitude, longitude, index);
      return Right(res);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> sendTrain(BuildContext context,
      String trainName, String station, DateTime time) async {
    try {
      final res = await crudTrain.sendTrain(context, trainName, station, time);
      return Right(res);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> editTrain(
      BuildContext context,
      String trainName,
      String station,
      DateTime time,
      DocumentReference<Object?> index) async {
    try {
      final res =
          await crudTrain.editTrain(context, trainName, station, time, index);
      return Right(res);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> removeNews(
      DocumentReference<Object?> index, String coverUrl) async {
    try {
      final res = await crudNews.removeNews(index, coverUrl);
      return Right(res);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> removeTour(
      DocumentReference<Object?> index, String coverUrl) async {
    try {
      final res = await crudTour.removeTour(index, coverUrl);
      return Right(res);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> removeTrain(
      DocumentReference<Object?> index) async {
    try {
      final res = await crudTrain.removeTrain(index);
      return Right(res);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> removeUmkm(
      DocumentReference<Object?> index, String coverUrl) async {
    try {
      final res = await crudUmkm.removeUmkm(index, coverUrl);
      return Right(res);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
