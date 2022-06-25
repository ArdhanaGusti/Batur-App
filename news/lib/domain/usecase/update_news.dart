import 'dart:io';
import '../../domain/repositories/data_repository.dart';
import '../../utils/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class UpdateNews {
  final DataRepository repository;

  UpdateNews(this.repository);

  Future<Either<Failure, String>> execute(
      BuildContext context,
      File? imageNow,
      String? imageNameNow,
      String judulNow,
      kontenNow,
      urlNameNow,
      DocumentReference index) {
    return repository.editNews(context, imageNow, imageNameNow, judulNow,
        kontenNow, urlNameNow, index);
  }
}
