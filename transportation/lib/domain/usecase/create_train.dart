import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:theme/common/failure.dart';
import 'package:transportation/domain/repository/data_repository_trans.dart';

class CreateTrain {
  final DataRepositoryTrans repository;

  CreateTrain(this.repository);

  Future<Either<Failure, String>> execute(
      BuildContext context, String trainName, String station, DateTime time) {
    return repository.sendTrain(context, trainName, station, time);
  }
}
