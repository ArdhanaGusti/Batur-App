import 'dart:io';

import 'package:account/domain/repository/data_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class EditProfile {
  final DataAccountRepository repository;

  EditProfile(this.repository);

  Future<Either<Failure, String>> execute(
    String username,
    String fullname,
    String? imageName,
    String urlNameNow,
    File? image,
    DocumentReference index,
  ) async {
    return repository.editProfile(
      username,
      fullname,
      imageName,
      urlNameNow,
      image,
      index,
    );
  }
}
