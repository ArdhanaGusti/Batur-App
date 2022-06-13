import 'dart:io';
import 'package:capstone_design/domain/repository/data_repository.dart';
import 'package:capstone_design/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CreateUmkm {
  final DataRepository repository;

  CreateUmkm(this.repository);

  Future<Either<Failure, String>> execute(BuildContext context,
      String imageName, name, type, File image, Position currentLocation) {
    return repository.sendUmkm(
        context, imageName, name, type, image, currentLocation);
  }
}
