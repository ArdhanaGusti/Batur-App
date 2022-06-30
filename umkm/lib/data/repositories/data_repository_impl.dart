import 'dart:io';
import '../../data/datasources/crud_umkm.dart';
import '../../domain/repository/data_repository.dart';
import '../../utils/exception.dart';
import '../../utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataRepositoryImplUmkm implements DataRepositoryUmkm {
  final CrudUmkm crudUmkm;

  DataRepositoryImplUmkm({
    required this.crudUmkm,
  });

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
  Future<Either<Failure, String>> sendUmkm(
    BuildContext context,
    String imageName,
    String address,
    String phone,
    String shopee,
    String tokped,
    String website,
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
          address,
          phone,
          shopee,
          tokped,
          website,
          name,
          type,
          desc,
          image,
          latitude,
          longitude);
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

  @override
  Future<Either<Failure, String>> addFavorite(
      String username, String email, String umkm) async {
    try {
      final res = await crudUmkm.addFavorite(username, email, umkm);
      return Right(res);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> removeFavorite(
      DocumentReference<Object?> index) async {
    try {
      final res = await crudUmkm.removeFavorite(index);
      return Right(res);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
