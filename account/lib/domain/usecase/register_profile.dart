import 'dart:io';

import 'package:account/domain/repository/data_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class RegisterProfile {
  final DataAccountRepository repository;

  RegisterProfile(this.repository);

  Future<Either<Failure, String>> execute(
    String username,
    String fullname,
    String imageName,
    String email,
    File image,
  ) async {
    return repository.registerProfile(
      username,
      fullname,
      imageName,
      email,
      image,
    );
  }
}
