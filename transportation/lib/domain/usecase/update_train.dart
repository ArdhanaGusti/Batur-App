import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:theme/common/failure.dart';
import 'package:transportation/domain/repository/data_repository_trans.dart';

class UpdateTrain {
  final DataRepositoryTrans repository;

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
