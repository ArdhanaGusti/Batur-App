import 'dart:io';
import '../../utils/failure.dart';
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
}
