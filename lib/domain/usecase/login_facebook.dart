import 'package:capstone_design/domain/repository/data_repository.dart';
import 'package:capstone_design/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class LoginFacebook {
  final DataRepository repository;

  LoginFacebook(this.repository);

  Future<Either<Failure, String>> execute(BuildContext context) {
    return repository.signInWithFacebook(context);
  }
}
