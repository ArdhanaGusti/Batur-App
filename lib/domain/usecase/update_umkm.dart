import 'dart:io';
// import 'package:capstone_design/domain/repository/data_repository.dart';
// import 'package:capstone_design/utils/failure.dart';
import 'package:umkm/umkm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

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
      index,
    );
  }
}
