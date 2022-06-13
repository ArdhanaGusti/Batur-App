import 'dart:io';
import 'package:capstone_design/domain/repository/data_repository.dart';
import 'package:capstone_design/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateProfile {
  final DataRepository repository;

  CreateProfile(this.repository);

  Future<Either<Failure, String>> execute(BuildContext context, String username,
      fullname, imageName, email, File image, User user) {
    return repository.sendProfile(
        context, username, fullname, imageName, email, image, user);
  }
}
