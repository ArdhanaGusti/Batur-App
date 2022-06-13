import 'dart:io';
import 'package:capstone_design/domain/repository/data_repository.dart';
import 'package:capstone_design/utils/failure.dart';
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
