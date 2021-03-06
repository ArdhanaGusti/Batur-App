import 'dart:io';
import '../../domain/repository/data_repository.dart';
import '../../utils/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
// import 'package:latlong2/latlong.dart';

class UpdateUmkm {
  final DataRepositoryUmkm repository;

  UpdateUmkm(this.repository);

  Future<Either<Failure, String>> execute(
    BuildContext context,
    File? image,
    String coverUrlNow,
    String? imageName,
    String nameNow,
    String typeNow,
    String descNow,
    double latitude,
    double longitude,
    String address,
    String? phone,
    String? shopee,
    String? tokped,
    String? website,
    DocumentReference index,
  ) {
    return repository.editUmkm(
      context,
      image,
      coverUrlNow,
      imageName,
      nameNow,
      typeNow,
      descNow,
      latitude,
      longitude,
      address,
      phone,
      shopee,
      tokped,
      website,
      index,
    );
  }
}
