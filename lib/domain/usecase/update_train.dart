import 'package:capstone_design/domain/repository/data_repository.dart';
import 'package:capstone_design/utils/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class UpdateTrain {
  final DataRepository repository;

  UpdateTrain(this.repository);

  Future<Either<Failure, String>> execute(
      BuildContext context,
      String trainName,
      String station,
      DateTime time,
      DocumentReference<Object?> index) {
    return repository.editTrain(context, trainName, station, time, index);
  }
}
