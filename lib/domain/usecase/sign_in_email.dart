import 'package:capstone_design/domain/repository/data_repository.dart';
import 'package:capstone_design/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class SignInEmail {
  final DataRepository repository;

  SignInEmail(this.repository);

  Future<Either<Failure, String>> execute(
      BuildContext context, String email, String pass) {
    return repository.signInWithEmail(context, email, pass);
  }
}
