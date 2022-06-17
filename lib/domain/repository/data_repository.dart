import 'dart:io';
import 'package:capstone_design/utils/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

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
  Future<Either<Failure, String>> sendUmkm(
      BuildContext context,
      String imageName,
      String name,
      String type,
      String desc,
      File image,
      Position currentLocation);
  Future<Either<Failure, String>> editUmkm(
      BuildContext context,
      File? image,
      String coverUrlNow,
      String? imageName,
      String nameNow,
      String typeNow,
      String descNow,
      LatLng center,
      DocumentReference index);
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
      Position currentLocation);
  Future<Either<Failure, String>> editTour(
    BuildContext context,
    File? image,
    String coverUrlNow,
    String? imageName,
    nameNow,
    typeNow,
    String descNow,
    LatLng center,
    DocumentReference index,
  );
  Future<Either<Failure, String>> sendTrain(
      BuildContext context, String trainName, String station, DateTime time);
  Future<Either<Failure, String>> editTrain(
      BuildContext context,
      String trainName,
      String station,
      DateTime time,
      DocumentReference<Object?> index);
}
