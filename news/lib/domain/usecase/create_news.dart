import 'dart:io';
import '../../domain/repositories/data_repository.dart';
import '../../utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class CreateNews {
  final DataRepository repository;

  CreateNews(this.repository);

  Future<Either<Failure, String>> execute(
      BuildContext context, File image, String imageName, judul, konten) {
    return repository.sendNews(context, image, imageName, judul, konten);
  }
}
