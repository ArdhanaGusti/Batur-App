// import 'dart:io';
// // import 'package:capstone_design/domain/repository/data_repository.dart';
// // import 'package:capstone_design/utils/failure.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:umkm/umkm.dart';

// class CreateUmkm {
//   final DataRepositoryUmkm repository;

//   CreateUmkm(this.repository);

//   Future<Either<Failure, String>> execute(
//     BuildContext context,
//     String imageName,
//     String name,
//     String type,
//     String desc,
//     File image,
//     double latitude,
//     double longitude,
//   ) {
//     return repository.sendUmkm(
//       context,
//       imageName,
//       name,
//       type,
//       desc,
//       image,
//       latitude,
//       longitude,
//     );
//   }
// }
