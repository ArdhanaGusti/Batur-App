import 'dart:io';
import '../../domain/repository/data_repository.dart';
import '../../utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CreateUmkm {
  final DataRepositoryUmkm repository;

  CreateUmkm(this.repository);

  Future<Either<Failure, String>> execute(
    BuildContext context,
    String imageName,
    String address,
    String phone,
    String shopee,
    String tokped,
    String website,
    String name,
    String type,
    String desc,
    File image,
    double latitude,
    double longitude,
  ) {
    return repository.sendUmkm(context, imageName, address, phone, shopee,
        tokped, website, name, type, desc, image, latitude, longitude);
  }
}
