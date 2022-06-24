import 'dart:io';
import 'package:capstone_design/domain/repository/data_repository.dart';
import 'package:capstone_design/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CreateTour {
  final DataRepository repository;

  CreateTour(this.repository);

  Future<Either<Failure, String>> execute(
    BuildContext context,
    String imageName,
    String name,
    String type,
    String desc,
    File image,
    double latitude,
    double longitude,
  ) {
    return repository.sendTour(
      context,
      imageName,
      name,
      type,
      desc,
      image,
      latitude,
      longitude,
    );
  }
}
