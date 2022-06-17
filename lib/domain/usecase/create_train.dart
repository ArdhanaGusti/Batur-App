import 'package:capstone_design/domain/repository/data_repository.dart';
import 'package:capstone_design/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class CreateTrain {
  final DataRepository repository;

  CreateTrain(this.repository);

  Future<Either<Failure, String>> execute(
      BuildContext context, String trainName, String station, DateTime time) {
    return repository.sendTrain(context, trainName, station, time);
  }
}
