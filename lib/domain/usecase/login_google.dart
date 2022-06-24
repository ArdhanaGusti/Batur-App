import 'package:capstone_design/domain/repository/data_repository.dart';
import 'package:capstone_design/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class LoginGoogle {
  final DataRepository repository;

  LoginGoogle(this.repository);

  Future<Either<Failure, String>> execute(BuildContext context) {
    return repository.signInbyGoogle(context);
  }
}
