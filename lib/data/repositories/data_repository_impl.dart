import 'dart:io';
import 'package:capstone_design/data/datasources/crud_news.dart';
import 'package:capstone_design/data/datasources/crud_profile.dart';
import 'package:capstone_design/data/datasources/crud_umkm.dart';
import 'package:capstone_design/domain/repository/data_repository.dart';
import 'package:capstone_design/utils/exception.dart';
import 'package:capstone_design/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataRepositoryImpl implements DataRepository {
  final CrudUmkm crudUmkm;
  final CrudNews crudNews;
  final CrudProfile crudProfile;

  DataRepositoryImpl({
    required this.crudUmkm,
    required this.crudNews,
    required this.crudProfile,
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
      imageName,
      nameNow,
      typeNow,
      LatLng center,
      DocumentReference<Object?> index) async {
    try {
      final res = await crudUmkm.editUmkm(context, image, coverUrlNow,
          imageName, nameNow, typeNow, center, index);
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
      name,
      type,
      File image,
      Position currentLocation) async {
    try {
      final res = await crudUmkm.sendUmkm(
          context, imageName, name, type, image, currentLocation);
      return Right(res);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}