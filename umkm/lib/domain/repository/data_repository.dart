import 'dart:io';
import '../../utils/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

abstract class DataRepositoryUmkm {
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
  );
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
      DocumentReference index);
  Future<Either<Failure, String>> removeUmkm(
      DocumentReference index, String coverUrl);
  Future<Either<Failure, String>> addFavorite(
      String username, String email, String umkm);
  Future<Either<Failure, String>> removeFavorite(DocumentReference index);
}
