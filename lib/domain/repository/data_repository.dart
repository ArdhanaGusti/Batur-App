import 'dart:io';
import 'package:capstone_design/utils/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class DataRepository {
  Future<Either<Failure, String>> sendNews(
      BuildContext context, File image, String imageName, judul, konten);
  Future<Either<Failure, String>> editNews(
      BuildContext context,
      File? imageNow,
      String? imageNameNow,
      String judulNow,
      kontenNow,
      urlNameNow,
      DocumentReference index);
  Future<Either<Failure, String>> removeNews(
      DocumentReference index, String coverUrl);
  Future<Either<Failure, String>> sendUmkm(
    BuildContext context,
    String imageName,
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
  Future<Either<Failure, String>> sendProfile(BuildContext context,
      String username, fullname, imageName, email, File image, User user);
  Future<Either<Failure, String>> editProfile(
      BuildContext context,
      String usernameNow,
      fullnameNow,
      imageName,
      urlNameNow,
      File? image,
      DocumentReference index);
  Future<Either<Failure, String>> sendTour(
    BuildContext context,
    String imageName,
    String name,
    String type,
    String desc,
    File image,
    double latitude,
    double longitude,
  );
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
  );
  Future<Either<Failure, String>> removeTour(
      DocumentReference index, String coverUrl);
  Future<Either<Failure, String>> sendTrain(
      BuildContext context, String trainName, String station, DateTime time);
  Future<Either<Failure, String>> editTrain(
      BuildContext context,
      String trainName,
      String station,
      DateTime time,
      DocumentReference<Object?> index);
  Future<Either<Failure, String>> removeTrain(DocumentReference index);
  Future<Either<Failure, String>> signInbyGoogle(BuildContext context);
  Future<Either<Failure, String>> signInWithFacebook(BuildContext context);
  Future<Either<Failure, String>> loginWithEmail(
      BuildContext context, String email, String pass);
  Future<Either<Failure, String>> signInWithEmail(
      BuildContext context, String email, String pass);
}
