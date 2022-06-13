import 'dart:io';
import 'package:capstone_design/domain/repository/data_repository.dart';
import 'package:capstone_design/utils/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class UpdateProfile {
  final DataRepository repository;

  UpdateProfile(this.repository);

  Future<Either<Failure, String>> execute(
      BuildContext context,
      String usernameNow,
      fullnameNow,
      imageName,
      urlNameNow,
      File? image,
      DocumentReference index) {
    return repository.editProfile(
        context, usernameNow, fullnameNow, imageName, urlNameNow, image, index);
  }
}
